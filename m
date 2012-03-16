From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] [#7001] framebuffer: old image of
	last app would retain for a while after starting new app
Date: Fri, 16 Mar 2012 01:21:37 -0400
Message-ID: <201203160121.38650.vapier@gentoo.org>
References: <1331628439-12719-1-git-send-email-Aaron.Wu@analog.com>
	<201203152354.33365.vapier@gentoo.org>
	<DB904C5425BA6F4E8424B3B51A1414D16F24304D64@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0257404461028803304=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1S8Pbh-00058W-VR
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Mar 2012 05:21:41 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S8Pbh-0004pG-11
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Mar 2012 05:21:41 +0000
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16F24304D64@NWD2CMBX1.ad.analog.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, "Wu, Aaron" <Aaron.Wu@analog.com>, linux-fbdev-devel@lists.sourceforge.net

--===============0257404461028803304==
Content-Type: multipart/signed; boundary="nextPart5923779.7REj6ofopc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5923779.7REj6ofopc
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 16 March 2012 01:05:10 Zhang, Sonic wrote:
> From: Mike Frysinger [mailto:vapier@gentoo.org]
>> On Thursday 15 March 2012 23:34:08 Zhang, Sonic wrote:
>>> From: Mike Frysinger [mailto:vapier@gentoo.org]
>>>> On Thursday 15 March 2012 05:23:50 Wu, Aaron wrote:
>>>>> Old image of last application would retain for a while when
>>>>> starting a new application, this patch clear the frambuffer before
>>>>> displaying every time the fb is opened.
>>>>=20
>>>> i'm not sure the behavior you describe is wrong.  in fact, i'm pretty
>>>> sure it sounds correct.  if an app writes an image to the framebuffer
>>>> and then quits, that image should stay there indefinitely until
>>>> something else opens the framebuffer and draws their own image.
>>>=20
>>> Before the second application draws its own image, the image of last
>>> application has already been displayed on the LCD when the second
>>> application opens the FB device(PPI is enabled when it is opened).
>>> This is not a correct behavior.
>>=20
>> sure it is.  if the app wants to clear the screen, it can do so.  genera=
lly
>> it's going to anyways by drawing an entire frame.  having the frame buff=
er
>> driver always clear the screen introduces wasted memory overhead as it
>> does the memset(), and user-visible jank as the device transitions from =
an
>> initial splash screen to the main userspace app.
>>=20
>> this is a policy decision that doesn't really belong in kernel space.  a=
nd
>> if it did, it should be agreed upon by all frame buffer users and not ju=
st
>> changing a few drivers.
>=20
> How can the application clean the screen before it opens the FB device?

why does it need to be before open ?  if the kernel does the memset or=20
userspace does the memset, the frame still gets cleared.

in looking at the blackfin framebuffer drivers, i'm not sure they're correc=
t.  i=20
don't think the PPI/DMA should be shutdown when the last user space client=
=20
closes it.  fb_release is for releasing all resources when tearing down the=
=20
driver, and fb_blank is runtime management (turning off vsync/hsync and=20
powering down the screen).
=2Dmike

--nextPart5923779.7REj6ofopc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPYs3iAAoJEEFjO5/oN/WBxl4P/iHpnAG3fvuYOHcN4O/XSVlO
/6PHottAzRQOgyUCe6+YXxr7hYCT3pkueWd/WiC/nM1aQg+zIvBr2BGNPYlEJPO3
mLG46oldtB24/IvYL7sqR8Emr8IapnMvqHc8tq6FicLdXuu5P6vuob6Ab0yX2Dqh
EcPSZ/ShArWM6LIdq3IoUhlulL19uQby/ELdt0W7OAVUHJHzKmbUAMEog6hHi20z
KHN+X3Ip2KKmw5i74E48r/yeANR02CviHwb4hQCz7ZHbmhH4t67T69GBp1IeVYgk
F/y6yzBUYjOY7eJ+BzSk4swCishJ98MAF4V3bNRUZBr8qZmIm8fQerVMTjmUOZiF
JfjZDsu5ueTHoBB1vZdiQEZJ1DtxYTKQAO6murenQlo0UMQknzx/cePQx5LMYfuP
7yNZ2QWVrpSiRQHZOg2mwQPCQeaECD2NLWFhRLNGGmfM22BT3gLpMpRxVFwQH888
FBnwpWHK6BSzMWSJMgp6q4Yb5hTokIJRSoRB3cHqImKrGufLs3R95mNQNFiNz8Mz
rkFQ9z2Bf0uHrfT2sgOrhTVEzWI+iGCmu3XRRvpcszZeAhgAgUij8f/sjqUbgGWL
2vs8JoIuwq1f6KS7GhOsLT5mzrLshHA2sSbpHxEj43CNNZ37ebv5qnMyA/osDDbU
hecDRR2PxuXSwJNZW3Ax
=pNIG
-----END PGP SIGNATURE-----

--nextPart5923779.7REj6ofopc--


--===============0257404461028803304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============0257404461028803304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0257404461028803304==--
