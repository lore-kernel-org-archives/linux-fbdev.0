From: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: Radeonfb patch and riva
Date: Wed, 5 Jun 2002 14:20:37 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0206051419380.98173-200000@shell.unixbox.com>
References: <Pine.LNX.4.44.0206051037300.26645-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1792584955-1023312037=:98173"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from shell.unixbox.com ([207.211.45.65])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Fi3r-00047P-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Jun 2002 14:11:20 -0700
In-Reply-To: <Pine.LNX.4.44.0206051037300.26645-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-1792584955-1023312037=:98173
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hmm, dunno what happened there, attatched is another diff, should apply
cleanly now.  Its against 2.4.19-pre9.


ani

On Wed, 5 Jun 2002, James Simmons wrote:

>
> Joshi I looked at the riva part of your patch and it doesn't line up with
> wgat is in Linus tree. Do you a link to your latest riva fbdev driver ?
>
>
>    . ---
>    |o_o |
>    |:_/ |   Give Micro$oft the Bird!!!!
>   //   \ \  Use Linux!!!!
>  (|     | )
>  /'\_   _/`\
>  \___)=(___/
>
>
> _______________________________________________________________
>
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
>
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>

--0-1792584955-1023312037=:98173
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="rivafb-nv3-fix.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.BSF.4.44.0206051420370.98173@shell.unixbox.com>
Content-Description: 
Content-Disposition: attachment; filename="rivafb-nv3-fix.diff"

ZGlmZiAtdU5yIGxpbnV4Lm9yaWcvZHJpdmVycy92aWRlby9yaXZhL2ZiZGV2
LmMgbGludXgvZHJpdmVycy92aWRlby9yaXZhL2ZiZGV2LmMNCi0tLSBsaW51
eC5vcmlnL2RyaXZlcnMvdmlkZW8vcml2YS9mYmRldi5jCVdlZCBKdW4gIDUg
MTY6NTM6MzggMjAwMg0KKysrIGxpbnV4L2RyaXZlcnMvdmlkZW8vcml2YS9m
YmRldi5jCVdlZCBKdW4gIDUgMTY6NTg6MzEgMjAwMg0KQEAgLTE5MTIsNiAr
MTkxMiwyNiBAQA0KIA0KIAlyaW5mby0+cml2YS5JTyA9IChNSVNDaW4ocmlu
Zm8pICYgMHgwMSkgPyAweDNEMCA6IDB4M0IwOw0KIA0KKwlpZiAocmluZm8t
PnJpdmEuQXJjaGl0ZWN0dXJlID09IE5WX0FSQ0hfMDMpIHsNCisJCS8qDQor
CQkgKiBXZSBoYXZlIHRvIG1hcCB0aGUgZnVsbCBCQVNFXzEgYXBlcnR1cmUg
Zm9yIFJpdmExMjgncw0KKwkJICogYmVjYXVzZSB0aGV5IHVzZSB0aGUgUFJB
TUlOIHNldCBpbiAiZnJhbWVidWZmZXIiIHNwYWNlDQorCQkgKi8NCisJCWlm
ICghcmVxdWVzdF9tZW1fcmVnaW9uKHJpbmZvLT5mYl9iYXNlX3BoeXMsDQor
CQkJCQlyaW5mby0+YmFzZTFfcmVnaW9uX3NpemUsICJyaXZhZmIiKSkgew0K
KwkJCXByaW50ayhLRVJOX0VSUiBQRlggImNhbm5vdCByZXNlcnZlIEZCIHJl
Z2lvblxuIik7DQorCQkJZ290byBlcnJfb3V0X2ZyZWVfYmFzZTA7DQorCQl9
DQorCQ0KKwkJcmluZm8tPmZiX2Jhc2UgPSBpb3JlbWFwKHJpbmZvLT5mYl9i
YXNlX3BoeXMsDQorCQkJCQkgcmluZm8tPmJhc2UxX3JlZ2lvbl9zaXplKTsN
CisJCWlmICghcmluZm8tPmZiX2Jhc2UpIHsNCisJCQlwcmludGsoS0VSTl9F
UlIgUEZYICJjYW5ub3QgaW9yZW1hcCBGQiBiYXNlXG4iKTsNCisJCQlnb3Rv
IGVycl9vdXRfaW91bm1hcF9jdHJsOw0KKwkJfQ0KKwl9DQorDQorDQogCXN3
aXRjaCAocmluZm8tPnJpdmEuQXJjaGl0ZWN0dXJlKSB7DQogCWNhc2UgTlZf
QVJDSF8wMzoNCiAJCXJpbmZvLT5yaXZhLlBSQU1JTiA9ICh1bnNpZ25lZCAq
KShyaW5mby0+ZmJfYmFzZSArIDB4MDBDMDAwMDApOw0KQEAgLTE5MjksMTcg
KzE5NDksMjMgQEANCiAJcmluZm8tPnJhbV9hbW91bnQgPSByaW5mby0+cml2
YS5SYW1BbW91bnRLQnl0ZXMgKiAxMDI0Ow0KIAlyaW5mby0+ZGNsa19tYXgg
PSByaW5mby0+cml2YS5NYXhWQ2xvY2tGcmVxS0h6ICogMTAwMDsNCiANCi0J
aWYgKCFyZXF1ZXN0X21lbV9yZWdpb24ocmluZm8tPmZiX2Jhc2VfcGh5cywN
Ci0JCQkJcmluZm8tPnJhbV9hbW91bnQsICJyaXZhZmIiKSkgew0KLQkJcHJp
bnRrKEtFUk5fRVJSIFBGWCAiY2Fubm90IHJlc2VydmUgRkIgcmVnaW9uXG4i
KTsNCi0JCWdvdG8gZXJyX291dF9mcmVlX2Jhc2UwOw0KLQl9DQorCWlmIChy
aW5mby0+cml2YS5BcmNoaXRlY3R1cmUgIT0gTlZfQVJDSF8wMykgew0KKwkJ
LyoNCisJCSAqIE5vdyB0aGUgX25vcm1hbF8gY2hpcHNldHMgY2FuIGp1c3Qg
bWFwIHRoZSBhbW91bnQgb2YNCisJCSAqIHJlYWwgcGh5c2ljYWwgcmFtIGlu
c3RlYWQgb2YgdGhlIHdob2xlIGFwZXJ0dXJlDQorCQkgKi8NCisJCWlmICgh
cmVxdWVzdF9tZW1fcmVnaW9uKHJpbmZvLT5mYl9iYXNlX3BoeXMsDQorCQkJ
CQlyaW5mby0+cmFtX2Ftb3VudCwgInJpdmFmYiIpKSB7DQorCQkJcHJpbnRr
KEtFUk5fRVJSIFBGWCAiY2Fubm90IHJlc2VydmUgRkIgcmVnaW9uXG4iKTsN
CisJCQlnb3RvIGVycl9vdXRfZnJlZV9iYXNlMDsNCisJCX0NCiAJDQotCXJp
bmZvLT5mYl9iYXNlID0gaW9yZW1hcChyaW5mby0+ZmJfYmFzZV9waHlzLA0K
LQkJCQkgcmluZm8tPnJhbV9hbW91bnQpOw0KLQlpZiAoIXJpbmZvLT5mYl9i
YXNlKSB7DQotCQlwcmludGsoS0VSTl9FUlIgUEZYICJjYW5ub3QgaW9yZW1h
cCBGQiBiYXNlXG4iKTsNCi0JCWdvdG8gZXJyX291dF9pb3VubWFwX2N0cmw7
DQorCQlyaW5mby0+ZmJfYmFzZSA9IGlvcmVtYXAocmluZm8tPmZiX2Jhc2Vf
cGh5cywNCisJCQkJCSByaW5mby0+cmFtX2Ftb3VudCk7DQorCQlpZiAoIXJp
bmZvLT5mYl9iYXNlKSB7DQorCQkJcHJpbnRrKEtFUk5fRVJSIFBGWCAiY2Fu
bm90IGlvcmVtYXAgRkIgYmFzZVxuIik7DQorCQkJZ290byBlcnJfb3V0X2lv
dW5tYXBfY3RybDsNCisJCX0NCiAJfQ0KIA0KICNpZmRlZiBDT05GSUdfTVRS
Ug0K
--0-1792584955-1023312037=:98173--

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
