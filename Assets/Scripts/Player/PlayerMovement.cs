using UnityEngine;
using System.Collections;

public class PlayerMovement : MonoBehaviour
{
    public float turnSmoothing = 15;
    public float speedDampTime = 0.1f;

    private Transform mainCameraPos;
    public Animator anim;

    void Start()
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

        MovementManagement(h, v, running);

        if (Input.GetKeyDown(KeyCode.C))
        {
            anim.SetBool("BehindCover", !anim.GetBool("BehindCover"));
        } 
        
        if (Input.GetMouseButtonDown(1))
        {
            anim.SetBool("Aiming", !anim.GetBool("Aiming"));
        }
    }

    void MovementManagement(float horizontal, float vertical, float running)
    {
        if (horizontal != 0f || vertical != 0f)
        {
            Rotating(horizontal, vertical);
            anim.SetFloat("SpeedForward", 1.51f + running * 5.6f, speedDampTime, Time.deltaTime);
        }
        else
        {
            anim.SetFloat("SpeedForward", 0, speedDampTime, Time.deltaTime);
        }
    }

    void Rotating(float horizontal, float vertical)
    {
        Vector3 targetDirection = new Vector3(horizontal, 0f, vertical);
        targetDirection = Quaternion.AngleAxis(mainCameraPos.eulerAngles.y, Vector3.up) * targetDirection;
        Quaternion targetRotation = Quaternion.LookRotation(targetDirection, Vector3.up);
        Quaternion newRotation = Quaternion.Lerp(transform.rotation, targetRotation, turnSmoothing * Time.deltaTime);
        transform.rotation = newRotation;
    }
}
