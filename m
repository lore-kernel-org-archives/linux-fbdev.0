From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] [#7001] framebuffer: old image of
	last app would retain for a while after starting new app
Date: Thu, 15 Mar 2012 23:54:31 -0400
Message-ID: <201203152354.33365.vapier@gentoo.org>
References: <1331628439-12719-1-git-send-email-Aaron.Wu@analog.com>
	<201203151508.04564.vapier@gentoo.org>
	<DB904C5425BA6F4E8424B3B51A1414D16F24304D28@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0812645427006883287=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1S8OFQ-0003Cl-RZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Mar 2012 03:54:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S8OFP-000454-TD
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Mar 2012 03:54:36 +0000
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16F24304D28@NWD2CMBX1.ad.analog.com>
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

--===============0812645427006883287==
Content-Type: multipart/signed; boundary="nextPart3038206.pXqWmr0Egd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3038206.pXqWmr0Egd
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 15 March 2012 23:34:08 Zhang, Sonic wrote:
> From: Mike Frysinger [mailto:vapier@gentoo.org]
>> On Thursday 15 March 2012 05:23:50 Wu, Aaron wrote:
>> > Old image of last application would retain for a while when starting a
>> > new application, this patch clear the frambuffer before displaying
>> > every time the fb is opened.
>>=20
>> i'm not sure the behavior you describe is wrong.  in fact, i'm pretty su=
re
>> it sounds correct.  if an app writes an image to the framebuffer and then
>> quits, that image should stay there indefinitely until something else
>> opens the framebuffer and draws their own image.
>=20
> Before the second application draws its own image, the image of last
> application has already been displayed on the LCD when the second
> application opens the FB device(PPI is enabled when it is opened). This is
> not a correct behavior.

sure it is.  if the app wants to clear the screen, it can do so.  generally=
=20
it's going to anyways by drawing an entire frame.  having the frame buffer=
=20
driver always clear the screen introduces wasted memory overhead as it does=
=20
the memset(), and user-visible jank as the device transitions from an initi=
al=20
splash screen to the main userspace app.

this is a policy decision that doesn't really belong in kernel space.  and =
if=20
it did, it should be agreed upon by all frame buffer users and not just=20
changing a few drivers.
=2Dmike

--nextPart3038206.pXqWmr0Egd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPYrl5AAoJEEFjO5/oN/WBpG8P/AlYUMSnyEdZqhvYITieeRFs
/jTsew43Sr8Hi5+D2YCA27sDT6FeFiyxnoXaS8/uCD19GRzRHoQVbnwWiqWpVPXK
BmClHQQN+EENy59JWTNspTfxjMu15fqGmlNSEL7Hb04V3VXdu/RQ7etPLMupVSWv
Q0N0FHMz0I5vkwLPhwsQN+Huph7sRDyChXph1F/y5DqJPhVcafHD/7xWud9HR6gg
TXynM03CKIiFrM/f9xhOoypdl5Nc0e1KDL5VmRNqyonmX9BePrbjA5UySeharRSI
NQn/WEGpf4TP7Q3r57oZddj9ncsF2pFNJYJULE+w56ON3vWNbXrkGfuO0B9wVR0R
mhez+mhPqDlbLeID7pjUPRQCq0HC0uX2xhMuARLXmLhbviuQRPLkG/WhlJX+rem7
GSLTNobyQLTudWk6wOwKhVu1SyfVl8fksgzkt8MydpUvL6ePnCcx5A/V4IDCnDEO
7U077q8LJCQqCDJEHdyryKtMuH1t8Jh/e+Af2VRhaGtNL6KQJW/SpR8S3wJHlhaS
tuqa2SuZjkzkRAYsIlzBZA2Z9v6uRFBuszM51U7IcTkCbaX/tTeTo4h0IYZfqLml
FwFx5ivATXwFXufnW7+xNLelZFRWdrgRJk1zr/Vz/i9c7Fm/ICUMTy6vuFNE1h87
sROklEuU9PBIZfdEyHh5
=ciMM
-----END PGP SIGNATURE-----

--nextPart3038206.pXqWmr0Egd--


--===============0812645427006883287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============0812645427006883287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0812645427006883287==--
