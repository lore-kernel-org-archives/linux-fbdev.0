From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Feb 2015 14:06:48 +0000
Subject: Re: [PATCH] video: fbdev: use msecs_to_jiffies for time conversion
Message-Id: <54E73F78.3050009@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QVVbOv2imA2nRJLoL6of8eEBsphkp3l3w"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423214041-15818-1-git-send-email-hofrat@osadl.org> <54E72774.1070809@ti.com> <20150220140110.GA25767@opentech.at>
In-Reply-To: <20150220140110.GA25767@opentech.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Fabian Frederick <fabf@skynet.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--QVVbOv2imA2nRJLoL6of8eEBsphkp3l3w
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/02/15 16:01, Nicholas Mc Guire wrote:

>>>  	pr_debug("%s(): task ending\n", __func__);
>>> @@ -1460,7 +1460,7 @@ static void pxafb_disable_controller(struct pxa=
fb_info *fbi)
>>>  #ifdef CONFIG_FB_PXA_SMARTPANEL
>>>  	if (fbi->lccr0 & LCCR0_LCDT) {
>>>  		wait_for_completion_timeout(&fbi->refresh_done,
>>> -				200 * HZ / 1000);
>>> +				msecs_to_jiffies(200);
>>
>> That will not compile.

>  No compile warning or errors
>=20
>  could you send me the compile error message and the toolchain you
>  are using - this change should not really have any noticable impact.

I didn't compile it. It's missing a closing parenthesis.

This is one reason I'm not very fond of cleanups to drivers that the
patch sender cannot test... They may cause more problems than they help.

 Tomi



--QVVbOv2imA2nRJLoL6of8eEBsphkp3l3w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5z94AAoJEPo9qoy8lh71k08QAJQb1FOIwPhZmsk/w7v7TMRj
6BSgEarWJAnsZz0efZsZWJyIJJBfFGtFF7hJGeQ2LxMGuB6t/9+yyimia9thFzNg
bZGHJn6wD8Yk4WTA+uz8xwT4nwZrJwYp3kkFdbm9XlJRE3TkWSUdINPYqVryv5iy
LjnL1yURLbcZiRywI8lnhXgeJsywVblI5ABkwoxW2DtBJuNC4BwCs0LDcP7suT3f
YjeLc0RiU2fL7LrMbwfOTWDT2vLzL5fjbYgr8f3JjmxqE27the/0CBLzUg8hgPVc
40sQuT4j7cMIekEhA/lDr/1CtMNDonAAIExRmwbGfMEta5FqGFNFW6LjH+eVk2Wc
LjfE5Dr4UFa7eCsSbfdfQm8t8J7n9AeNwSLA2uupJfg2fQ1Uywa9J2XUzcJUi74J
QXrEeMGEfvpn0ULhY4leB4vL18lf1VnYu/nGnUtYF140mnKqMJWbISin/rku9jYn
UcEhzNuGkOsQSora0TtFeek2Dem4AIsUG88yjmLwRu8Y0j/YyfEit08IrAKavCsX
JA7uaG6H7qGhJX4ClZDgZWLyClXz3ETC2wzha4FgIIh3UJNnRAF2bfQxj7/OId1V
Ev+2c4QXOaT7ObtAJdZhupQFJdqiSnX7p69jtxaWi2XerUtyY7UmCywIIqLJBVu/
7Q2loL14XZj/qhwm25dy
=hG79
-----END PGP SIGNATURE-----

--QVVbOv2imA2nRJLoL6of8eEBsphkp3l3w--
