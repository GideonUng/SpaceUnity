using UnityEngine;
using System.Collections;

public class TPSCameraController : MonoBehaviour
{
	public float sensitivityX = 15F;
	public float sensitivityY = 15F;

	public float minimumX = -360F;
	public float maximumX = 360F;

	public float minimumY = -60F;
	public float maximumY = 60F;

	public float maxTurnSpeed;
	public bool mouseAcceleration;

	public GameObject Root;
	public Transform pivot;
	public Transform TPSCamera;

	private float rotationX = 0f;
	private float rotationY = 0F;

	void Start()
	{
		rotationY = Root.transform.rotation.eulerAngles.x;
		rotationX = Root.transform.rotation.eulerAngles.y;

		// Make the rigid body not change rotation
		if (GetComponent<Rigidbody>())
			GetComponent<Rigidbody>().freezeRotation = true;
	}

	void Update()
	{
		transform.position = GameObject.FindGameObjectWithTag("Player").transform.position;


		if (mouseAcceleration)
		{
			rotationX += Mathf.Clamp(Mathf.Abs(Input.GetAxis("Mouse X") * 0.4f) * Input.GetAxis("Mouse X") * sensitivityX * 2.5f, -maxTurnSpeed, maxTurnSpeed);
			rotationY += Mathf.Clamp(Mathf.Abs(Input.GetAxis("Mouse Y") * 0.4f) * Input.GetAxis("Mouse Y") * sensitivityY * 2.5f, -maxTurnSpeed, maxTurnSpeed);
		}
		else
		{
			rotationX += Mathf.Clamp(Input.GetAxis("Mouse X") * sensitivityX, -maxTurnSpeed, maxTurnSpeed);
			rotationY += Mathf.Clamp(Input.GetAxis("Mouse Y") * sensitivityY, -maxTurnSpeed, maxTurnSpeed);
		}
		rotationY = Mathf.Clamp(rotationY, minimumY, maximumY);

		Root.transform.localEulerAngles = new Vector3(-rotationY, rotationX, 0);
	}

	void LateUpdate()
	{
		RaycastHit hit;

		Physics.Raycast(Root.transform.position, -pivot.transform.forward, out hit, -pivot.localPosition.z);
		//Debug.DrawLine(Root.transform.position, hit.point);
		Debug.DrawRay(Root.transform.position, -pivot.transform.forward, Color.blue, 5f);

		if (hit.collider != null)
		{
			TPSCamera.localPosition = new Vector3(0, 0, Vector3.Distance(pivot.transform.position, hit.point));
		}
		else
		{
			TPSCamera.transform.localPosition = Vector3.zero;
		}
	}
}