From: "Vishal Soni" <vishal.soni@samsung.com>
Subject: Gives Bus error in memcpy() in coping /dev/fb0
	to a file.
Date: Wed, 7 Mar 2007 17:20:42 +0530
Message-ID: <426888a60703070350x48ee4d0eoa017bdb859e70f73@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58592_28483450.1173268242699"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOufM-0001lJ-LW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Mar 2007 03:50:44 -0800
Received: from wx-out-0506.google.com ([66.249.82.232])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOufM-00071A-9o
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Mar 2007 03:50:44 -0800
Received: by wx-out-0506.google.com with SMTP id i30so172241wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 07 Mar 2007 03:50:43 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

------=_Part_58592_28483450.1173268242699
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello,

I am trying to get the snapshot of the screen through a c program by mmaping
the framebuffer device /dev/fb0 .
For this i compiled kernel with virtual framebuffer support and passing
vga=791 as boot line argument.

Though i am able to get snapshot by
[root@tw pcapp]# cat /dev/fb0 > frame

and see it on the screen by
[root@tw pcapp]# cat frame > /dev/fb0

But when i try to capture the frame buffer using the below c code, It gives
bus error @ memcpy()

Output :::::::::

[root@tw pcapp]# ./pcapp
1024x768, 16bpp
framebuffer device mapped to memory @ 0xb7db3000.
FB_FRAME mapped to memory @ 0xb7c33000.
Bus error
[root@tw pcapp]#

Any pointers plz !!!!!
Vishal

------=_Part_58592_28483450.1173268242699
Content-Type: text/x-csrc; name=pcapp.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyzpkzm7
Content-Disposition: attachment; filename="pcapp.c"

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5o
PgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGxpbnV4L2ZiLmg+CiNpbmNsdWRlIDxzeXMv
bW1hbi5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxzeXMvc3RhdC5oPgojaW5j
bHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8c3RyaW5nLmg+
CgojZGVmaW5lIEZCX0ZJTEUgIi9kZXYvZmIwIgojZGVmaW5lIEZCX0ZSQU1FICJmYl9mcmFtZSIK
CmludCBtYWluIChpbnQgYXJnYywgY2hhciAqYXJndltdKQp7CglpbnQgZmRpbiA9IC0xOwoJaW50
IGZkb3V0ID0gLTE7CgljaGFyICpzcmMgPSBOVUxMOwoJY2hhciAqZHN0ID0gTlVMTDsKCXN0cnVj
dCBmYl92YXJfc2NyZWVuaW5mbyB2aW5mbzsKCWxvbmcgaW50IHNjcmVlbnNpemUgPSAwOwoKCWlm
ICgoZmRpbiA9IG9wZW4gKEZCX0ZJTEUsIE9fUkRPTkxZKSkgPCAwKSB7CgkJcHJpbnRmICgiRmFp
bGUgdG8gb3BlbiAlcyBmaWxlIiwgRkJfRklMRSk7CgkJcmV0dXJuIDA7Cgl9CgoJLyogb3Blbi9j
cmVhdGUgdGhlIG91dHB1dCBmaWxlICovCglpZiAoKGZkb3V0ID0gb3BlbiAoRkJfRlJBTUUsIE9f
UkRXUiB8IE9fQ1JFQVQgfCBPX1RSVU5DLCBTX0lSV1hVKSkgPCAwKSB7CgkJcHJpbnRmICgiZmFp
bGUgdG8gb3BlbiAlcyBmb3Igd3JpdGluZyIsIEZCX0ZSQU1FKTsKCQlyZXR1cm4gLTE7Cgl9CgoJ
Ly8gR2V0IHZhcmlhYmxlIHNjcmVlbiBpbmZvcm1hdGlvbgoJaWYgKGlvY3RsKGZkaW4sIEZCSU9H
RVRfVlNDUkVFTklORk8sICZ2aW5mbykpIHsKCQlwcmludGYoIkVycm9yIHJlYWRpbmcgdmFyaWFi
bGUgaW5mb3JtYXRpb24uXG4iKTsKCQlyZXR1cm4gLTE7Cgl9CgoJcHJpbnRmKCIlZHglZCwgJWRi
cHBcbiIsIHZpbmZvLnhyZXMsIHZpbmZvLnlyZXMsIHZpbmZvLmJpdHNfcGVyX3BpeGVsICk7CgoJ
Ly8gQ2FsY3VsYXRlIHRoZSBzaXplIG9mIHRoZSBzY3JlZW4gaW4gYnl0ZXMKCXNjcmVlbnNpemUg
PSB2aW5mby54cmVzICogdmluZm8ueXJlcyAqIHZpbmZvLmJpdHNfcGVyX3BpeGVsIC8gODsKCQoJ
Ly8gTWFwIHRoZSBkZXZpY2UgdG8gbWVtb3J5CglzcmMgPSAoY2hhciAqKW1tYXAoMCwgc2NyZWVu
c2l6ZSwgUFJPVF9SRUFELCBNQVBfU0hBUkVELCBmZGluLCAwKTsKCWlmICgoaW50KXNyYyA9PSAt
MSkgewoJCXByaW50ZigiRXJyb3I6IGZhaWxlZCB0byBtYXAgZnJhbWVidWZmZXIgZGV2aWNlIHRv
IG1lbW9yeS5cbiIpOwoJCXJldHVybiAtMTsKCX0KCgkvKiBtbWFwIHRoZSBGQl9GUkFNRSBmaWxl
ICovCglkc3QgPSBtbWFwICgwLCBzY3JlZW5zaXplLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCBN
QVBfUFJJVkFURSwgZmRvdXQsIDApOwoJaWYgKChpbnQpZHN0ID09IC0xKSB7CgkJcHJpbnRmKCJG
Ql9GUkFNRTo6IG1tYXAgZXJyb3IgICIpOwoJCXJldHVybiAtMTsKCX0KCQoJcHJpbnRmKCJmcmFt
ZWJ1ZmZlciBkZXZpY2UgbWFwcGVkIHRvIG1lbW9yeSBAICVwLlxuIiwgc3JjKTsKCXByaW50Zigi
RkJfRlJBTUUgbWFwcGVkIHRvIG1lbW9yeSBAICVwLlxuIiwgZHN0KTsKCS8qIGNvcHkgL2Rldi9m
YjAgdG8gZmJfZnJhbWUgZmlsZSAqLwoJbWVtY3B5IChkc3QsIHNyYywgc2NyZWVuc2l6ZSk7Cglj
bG9zZShmZGluKTsKCWNsb3NlKGZkb3V0KTsKCXJldHVybiAwOwp9IAo=
------=_Part_58592_28483450.1173268242699
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------=_Part_58592_28483450.1173268242699
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

------=_Part_58592_28483450.1173268242699--
