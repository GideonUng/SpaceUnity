using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class CharacterMovement : MonoBehaviour
{
    public float TurnSmoothing = 15;
    public float SpeedDampTime = 0.1f;

    public CoverNode CurentCoverNode;
    public bool BehindCover;

    private Animator anim;
	private CoverNode coverNode;
    void Awake()
    {
        anim = GetComponent<Animator>();
    }

    //public void MovementMager(float horizontal, float vertical, bool running, bool crouching, bool aiming)

    public void walkMovementManager(float horizontal, float vertical, float running, Quaternion rotation)
    {
        if (horizontal != 0f || vertical != 0f)
        {
            rotating(horizontal, vertical, rotation);
            anim.SetFloat("SpeedForward", 1.51f + running * 5.6f, SpeedDampTime, Time.deltaTime);
        }
        else
        {
            anim.SetFloat("SpeedForward", 0, SpeedDampTime, Time.deltaTime);
        }
    }

    public void aimingMovementManagement()
    {

    }

    public void behindCoverMovementManagement(float horizontal, float vertical)
    {
        if (horizontal >= 0.1f || vertical >= 0.1f)
        {
            anim.SetFloat("SpeedForward", 1);
			transform.rotation = Quaternion.Euler(0, 180 - Quaternion.FromToRotation(coverNode.BoundLeft.transform.position, coverNode.BoundRight.transform.position).eulerAngles.y, 0);
		}
		else if (horizontal <= -0.1f || vertical <= -0.1f)
		{
			transform.rotation = Quaternion.Euler(0, 180 - Quaternion.FromToRotation(coverNode.BoundLeft.transform.position, -coverNode.BoundRight.transform.position).eulerAngles.y, 0);
			anim.SetFloat("SpeedForward", -1);
		}
        else
        {
            anim.SetFloat("SpeedForward", 0);
        }
    }

    void rotating(float horizontal, float vertical, Quaternion rotation)
    {
        Vector3 targetDirection = new Vector3(horizontal, 0f, vertical);
        targetDirection = Quaternion.AngleAxis(rotation.eulerAngles.y, Vector3.up) * targetDirection;
        Quaternion targetRotation = Quaternion.LookRotation(targetDirection, Vector3.up);
        Quaternion newRotation = Quaternion.Lerp(transform.rotation, targetRotation, TurnSmoothing * Time.deltaTime);
        transform.rotation = newRotation;
    }

    void rotating(Quaternion targetRotation)
    {
        transform.rotation = targetRotation;
    }

    void rotating(Vector3 targetPosition)
    {
        // if necesary
    }

    public void moveToCover(CoverNode newCoverNode, Vector3 targetPosition)
    {
		coverNode = newCoverNode;
        anim.SetBool("BehindCover", true);
        transform.position = new Vector3(targetPosition.x, transform.position.y, targetPosition.z);
        transform.rotation = Quaternion.Euler(0, 180 - Quaternion.FromToRotation(coverNode.BoundLeft.transform.position, coverNode.BoundRight.transform.position).eulerAngles.y, 0);
    }
}
