From: Jon Smirl <jonsmirl@gmail.com>
Subject: Three fbdev bug fixes
Date: Thu, 28 Apr 2005 13:02:55 -0400
Message-ID: <9e47339105042810025d35a2ad@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9374_24204439.1114707775735"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRCPo-0005xS-5d
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Apr 2005 10:03:04 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DRCPm-0004D4-OQ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Apr 2005 10:03:04 -0700
Received: by wproxy.gmail.com with SMTP id 69so640632wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Apr 2005 10:02:55 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

------=_Part_9374_24204439.1114707775735
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

#1) fbdev is missing unregister_chrdev(FB_MAJOR, "fb");
#2) rounding issues can make an acceptable mode fail
added  hfreq =3D (hfreq + 500) / 1000 * 1000;
#3) Benh has picked this up. radeonfb is not deleting it's sysfs attributes
  sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
  sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);

All three are in the attachment

--=20
Jon Smirl
jonsmirl@gmail.com

------=_Part_9374_24204439.1114707775735
Content-Type: application/octet-stream; name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch"

PT09PT0gZHJpdmVycy92aWRlby9mYm1lbS5jIDEuMTYwIHZzIGVkaXRlZCA9PT09PQotLS0gMS4x
NjAvZHJpdmVycy92aWRlby9mYm1lbS5jCTIwMDUtMDMtMzEgMDY6MDY6NTIgLTA1OjAwCisrKyBl
ZGl0ZWQvZHJpdmVycy92aWRlby9mYm1lbS5jCTIwMDUtMDQtMjUgMDE6MzM6NTcgLTA0OjAwCkBA
IC0xMjExLDYgKzEyMTEsNyBAQAogZmJtZW1fZXhpdCh2b2lkKQogewogCWNsYXNzX3NpbXBsZV9k
ZXN0cm95KGZiX2NsYXNzKTsKKwl1bnJlZ2lzdGVyX2NocmRldihGQl9NQUpPUiwgImZiIik7CiB9
CiAKIG1vZHVsZV9leGl0KGZibWVtX2V4aXQpOwo9PT09PSBkcml2ZXJzL3ZpZGVvL2ZibW9uLmMg
MS4yMiB2cyBlZGl0ZWQgPT09PT0KLS0tIDEuMjIvZHJpdmVycy92aWRlby9mYm1vbi5jCTIwMDUt
MDMtMzEgMDY6MDY6NTIgLTA1OjAwCisrKyBlZGl0ZWQvZHJpdmVycy92aWRlby9mYm1vbi5jCTIw
MDUtMDQtMjUgMTM6NTg6MTMgLTA0OjAwCkBAIC0xMjQyLDYgKzEyNDIsOCBAQAogCQl2dG90YWwg
Kj0gMjsKIAogCWhmcmVxID0gcGl4Y2xvY2svaHRvdGFsOworCWhmcmVxID0gKGhmcmVxICsgNTAw
KSAvIDEwMDAgKiAxMDAwOworCQogCXZmcmVxID0gaGZyZXEvdnRvdGFsOwogCiAJcmV0dXJuICh2
ZnJlcSA8IHZmbWluIHx8IHZmcmVxID4gdmZtYXggfHwgCj09PT09IGRyaXZlcnMvdmlkZW8vYXR5
L3JhZGVvbl9iYXNlLmMgMS40OCB2cyBlZGl0ZWQgPT09PT0KLS0tIDEuNDgvZHJpdmVycy92aWRl
by9hdHkvcmFkZW9uX2Jhc2UuYwkyMDA1LTAzLTMxIDA2OjA2OjUyIC0wNTowMAorKysgZWRpdGVk
L2RyaXZlcnMvdmlkZW8vYXR5L3JhZGVvbl9iYXNlLmMJMjAwNS0wNC0yOCAxMjo1Njo1NSAtMDQ6
MDAKQEAgLTI0NTIsNiArMjQ1MiwxMSBAQAogIAogCXJhZGVvbmZiX3BtX2V4aXQocmluZm8pOwog
CisJaWYgKHJpbmZvLT5tb24xX0VESUQpCisJCXN5c2ZzX3JlbW92ZV9iaW5fZmlsZSgmcmluZm8t
PnBkZXYtPmRldi5rb2JqLCAmZWRpZDFfYXR0cik7CisJaWYgKHJpbmZvLT5tb24yX0VESUQpCisJ
CXN5c2ZzX3JlbW92ZV9iaW5fZmlsZSgmcmluZm8tPnBkZXYtPmRldi5rb2JqLCAmZWRpZDJfYXR0
cik7CisKICNpZiAwCiAJLyogcmVzdG9yZSBvcmlnaW5hbCBzdGF0ZQogCSAqIAo=
------=_Part_9374_24204439.1114707775735--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
