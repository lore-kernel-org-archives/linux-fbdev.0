From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 13 Jan 2015 10:35:35 +0000
Subject: Re: [PATCH 2/3] video: fbdev: Check Standard Timing against DMT
Message-Id: <54B4F4F7.6040704@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xfn6IXNbP8ph2MFWxQS97fSaOjO9rRWqd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--xfn6IXNbP8ph2MFWxQS97fSaOjO9rRWqd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/12/14 21:47, David Ung wrote:
>=20
>> On 03/12/14 23:49, David Ung wrote:
>>> Add the VESA Display Monitor Timing (DMT) table.
>>> During parsing of Standard Timings, it compare the 2 byte STD code
>>> with DMT to see what the VESA mode should be.  If there is no entry i=
n
>>> the vesa_modes table or no match found, it fallsback to the GTF
>>> timings.
>>>
>>> Signed-off-by: David Ung <davidu@nvidia.com>
>>> ---
>>>  drivers/video/fbdev/core/fbmon.c  | 20 ++++++----
>>> drivers/video/fbdev/core/modedb.c | 84
>> +++++++++++++++++++++++++++++++++++++++
>>>  include/linux/fb.h                | 10 +++++
>>>  3 files changed, 107 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/core/fbmon.c
>>> b/drivers/video/fbdev/core/fbmon.c
>>> index 5b0e313..aa1110a 100644
>>> --- a/drivers/video/fbdev/core/fbmon.c
>>> +++ b/drivers/video/fbdev/core/fbmon.c
>>> @@ -526,16 +526,22 @@ static int get_std_timing(unsigned char *block,=

>> struct fb_videomode *mode,
>>>  	refresh =3D (block[1] & 0x3f) + 60;
>>>
>>>  	DPRINTK("      %dx%d@%dHz\n", xres, yres, refresh);
>>> -	for (i =3D 0; i < VESA_MODEDB_SIZE; i++) {
>>> -		if (vesa_modes[i].xres =3D=3D xres &&
>>> -		    vesa_modes[i].yres =3D=3D yres &&
>>> -		    vesa_modes[i].refresh =3D=3D refresh) {
>>> -			*mode =3D vesa_modes[i];
>>> +	for (i =3D 0; i < DMT_SIZE; i++) {
>>> +		u32 std_2byte_code =3D block[0] << 8 | block[1];
>>> +
>>> +		if (std_2byte_code =3D=3D dmt_modes[i].std_2byte_code) {
>>> +			if (!dmt_modes[i].mode)
>>> +				break;
>>> +			*mode =3D *dmt_modes[i].mode;
>>>  			mode->flag |=3D FB_MODE_IS_STANDARD;
>>> -			return 1;
>>> +			DPRINTK("        DMT id=3D%d\n",
>> dmt_modes[i].dmt_id);
>>> +			break;
>>>  		}
>>>  	}
>>> -	calc_mode_timings(xres, yres, refresh, mode);
>>> +
>>> +	if (i =3D=3D DMT_SIZE || !dmt_modes[i].mode)
>>> +		calc_mode_timings(xres, yres, refresh, mode);
>>> +
>>>  	return 1;
>>>  }
>>
>> I think this could be made a bit cleaner.
>>
>> The xres/yres/refresh calculation in get_std_timing doesn't matter for=
 the
>> DMT code above. So in get_std_timing() you could first do the search f=
or the
>> DMT mode, and if found, return from the function. After that the code
>> would do the GTF calculation.
>>
>=20
> Yes, I've deleted the xres/yres/refresh calculation.

Sorry it's taken a while for me to respond...

I mean that the whole 'switch (ratio)' and related code in the beginning
of the get_std_timing() are not needed for the DMT loop. All that could
be moved inside the 'if (i =3D=3D DMT_SIZE || !dmt_modes[i].mode)' block.=


Also, in my opinion the code would be more easily understandable with
something like:

for (dmt loop) {
	if (std_2byte_code matches)
		break;
}

if (i < DMT_SIZE && dmt_modes[i].mode) {
	// DMT mode found
} else {
	// calculate GTF
}

 Tomi



--xfn6IXNbP8ph2MFWxQS97fSaOjO9rRWqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtPT3AAoJEPo9qoy8lh71N3MP/0IvnX5tALecC9BZq7sgF18U
3iEK/0ARmX3QcnAucQcmuBUVo5zlNVupLGnWsKLCoCZ7G25W8pI8bV2C03H1tI2o
MT1r7iOAsr5aJhBbNoVQMLOGE8hzppC1ibywWoMQIwZp8RWfAD7fnLCnNfvtOlfd
XP5+5Sy77RTY17R/NA++eYN8VrXZCz40J+KHzGJTSvOIkuUO49AERA1GLyqBgFI8
N30bvhrffn5ZCJCmExe7SwZLJZbaH33/6VIcH073XT8rwIRFihIoEgOQGyuLDZhE
jgBTBJmw/q3y/plx5V3hKkFGsXd8MWQk7CIbZN7eBGSgsWoA2fRpKt+qXfH3m8Kr
SL29ErQNvy4uONLKn9LH4AIoLnQtOMncJ9HHN1byx/C3L+LQqYgGNocVvDTXHK/e
1kJos4OOFMInrTgLhpVgAmgZ1Nk/Uwe1Vg/xWDTCAtWvBgj15pOrqKUOKwpN0gwm
nDTDveo3t3v9Ka8XRLAr8xIW0SNRKuQY30Hk2qjzaPn5X79ZQ7TyWTMhsgwO2sUs
/ELLItmM1K/gBJBKyY8Y3K19V39p7S8rlhX5kXCIb5h9f2Bk1SDfRwnjXECUh9Mk
7L43zqtJwl+dq6v04kXfJn8f0GzMCO5iuBbUXpPzH3aoZwKKsNX++HG6NfIsS3m1
+1fkjabMSGHxuJyaf+l3
=8xLR
-----END PGP SIGNATURE-----

--xfn6IXNbP8ph2MFWxQS97fSaOjO9rRWqd--
