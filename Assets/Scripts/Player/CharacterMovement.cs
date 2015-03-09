using UnityEngine;
using System.Collections;

public class CharacterMovement : MonoBehaviour
{
    public float TurnSmoothing = 15;
    public float SpeedDampTime = 0.1f;

    public CoverNode CurentCoverNode;

    private Transform mainCameraPos;
    private Animator anim;

    public bool BehindCover;

    void Awake()
    {
        mainCameraPos = GameObject.FindGameObjectWithTag("MainCamera").transform;
        anim = GetComponent<Animator>();
    }

    void Update()
    {
        if (anim == null)
        {
            Debug.Log("No animator Found");
            return;
        }

        float h = Input.GetAxis("Horizontal");
        float v = Input.GetAxis("Vertical");
        float running = Input.GetAxis("Running");
        bool aiming = Input.GetButton("Aiming");

        if (BehindCover)
        {
            behindCoverMovementManagement(h, v);
        }

        else if (aiming)
        {
            aimingMovementManagement();
        }
        else
        {
            walkMovementManager(h, v, running);
        }


        //Temp
        if (Input.GetKeyDown(KeyCode.C))
        {
            anim.SetBool("BehindCover", !anim.GetBool("BehindCover"));
        }

        if (Input.GetMouseButtonDown(1))
        {
            anim.SetBool("Aiming", !anim.GetBool("Aiming"));
        }
        //Temp


    }

    void walkMovementManager(float horizontal, float vertical, float running)
    {
        if (horizontal != 0f || vertical != 0f)
        {
            rotating(horizontal, vertical);
            anim.SetFloat("SpeedForward", 1.51f + running * 5.6f, SpeedDampTime, Time.deltaTime);
        }
        else
        {
            anim.SetFloat("SpeedForward", 0, SpeedDampTime, Time.deltaTime);
        }
    }

    void aimingMovementManagement()
    {

    }

    void behindCoverMovementManagement(float horizontal, float vertical)
    {

    }

    void rotating(float horizontal, float vertical)
    {
        Vector3 targetDirection = new Vector3(horizontal, 0f, vertical);
        targetDirection = Quaternion.AngleAxis(mainCameraPos.eulerAngles.y, Vector3.up) * targetDirection;
        Quaternion targetRotation = Quaternion.LookRotation(targetDirection, Vector3.up);
        Quaternion newRotation = Quaternion.Lerp(transform.rotation, targetRotation, TurnSmoothing * Time.deltaTime);
        transform.rotation = newRotation;
    }
}
