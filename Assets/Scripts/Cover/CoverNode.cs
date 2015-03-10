using UnityEngine;
using System.Collections;

public class CoverNode : MonoBehaviour
{
    public GameObject ConnectionRight;
    public GameObject ConnectionLeft;

    public Transform BoundRight;
    public Transform BoundLeft;

    public bool SafeFromPlayer;
    public bool SafeFromEnemy;

    public bool Occupied;

    public bool IsAtEdgeRight;
    public bool IsAtEdgeLeft;

    public GameObject PersonInCover;

    public float BoundThreshold;

    void Start()
    {

    }

    public virtual void Update()
    {
        if (Vector3.Distance(PersonInCover.transform.position, BoundRight.position) <= BoundThreshold)
        {
            IsAtEdgeRight = true;
        }
        else
        {
            IsAtEdgeRight = false;
        }
        if (Vector3.Distance(PersonInCover.transform.position, BoundLeft.position) <= BoundThreshold)
        {
            IsAtEdgeLeft = true;
        }
        else
        {
            IsAtEdgeLeft = false;
        }
    }

    public virtual bool EnterCoverr(GameObject person)
    {
        if (Occupied)
        {
            return false;
        }

        PersonInCover = person;

        return true;
    }
}