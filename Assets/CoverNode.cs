using UnityEngine;
using System.Collections;

public class CoverNode : MonoBehaviour
{
    public GameObject ConnectionRight;
    public GameObject ConnectionLeft;

    public Vector3 BoundRight;
    public Vector3 BoundLeft;

    public bool Safe;

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
        if (Vector3.Distance(PersonInCover.transform.position, BoundRight) <= BoundThreshold)
        {
            IsAtEdgeRight = true;
        }
        else
        {
            IsAtEdgeRight = false;
        }
        if (Vector3.Distance(PersonInCover.transform.position, BoundLeft) <= BoundThreshold)
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