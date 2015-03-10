using UnityEngine;
using System.Collections;

public class PlayerControl : MonoBehaviour
{
    private CharacterMovement charakterMovement;
    private Transform mainCameraPos;
    private Animator anim;

    private bool behindCover = false;

    void Awake()
    {
        charakterMovement = GetComponent<CharacterMovement>();
        mainCameraPos = GameObject.FindGameObjectWithTag("MainCamera").transform;
        anim = GetComponent<Animator>();
    }

    // Update is called once per frame
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
        bool crouching = Input.GetButton("Crouching");
        bool aiming = Input.GetButton("Aiming");
        bool moveToCover = Input.GetButtonUp("Cover");

        if (moveToCover)
        {
            RaycastHit hit;
            Physics.Raycast(transform.position + Vector3.up, mainCameraPos.forward, out hit, 2f, 1 << 15);

            if (hit.collider != null)
            {
                Debug.Log("hit");
                behindCover = true;
                charakterMovement.moveToCover(hit.collider.gameObject.GetComponent<StandingBoxCoverNode>(), hit.point);
            }
            else
            {
                Debug.Log("Not Hit");
            }
        }
        if (behindCover)
        {
            charakterMovement.behindCoverMovementManagement(h, v);
        }
        else if (!aiming && !crouching && !behindCover)
        {
            charakterMovement.walkMovementManager(h, v, running, mainCameraPos.transform.rotation);
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
}