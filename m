From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 12 Feb 2016 07:42:41 +0000
Subject: Re: [PATCH] video: fbdev: imxfb: Provide a reset mechanism
Message-Id: <56BD8CF1.3060003@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xxoh6UFcJ1AkNsWwnu5QHSvo7xcOS63nU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453209057-16444-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1453209057-16444-1-git-send-email-festevam@gmail.com>
To: linux-fbdev@vger.kernel.org

--xxoh6UFcJ1AkNsWwnu5QHSvo7xcOS63nU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/02/16 21:52, Fabio Estevam wrote:
> Hi Tomi,
>=20
> On Fri, Jan 29, 2016 at 10:20 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>>
>>
>> On 19/01/16 15:10, Fabio Estevam wrote:
>>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>>
>>> Currently when we boot the kernel on a mx25pdk the LCDC controller
>>> does not show the Linux logo on boot.
>>>
>>> This problem is well explained by Sascha Hauer:
>>>
>>> "Unfortunately this LCD controller does not have an enable bit. The
>>> controller starts directly when the clocks are enabled. If the clocks=

>>> are enabled when the controller is not yet programmed with proper
>>> register values then it just goes into some undefined state. What I
>>> suspect is that the clocks already were enabled before driver probe,
>>> presumably by the bootloader, so the controller is already in undefin=
ed
>>> state when entering Linux. Now by dis/enabling the ipg clock you
>>> effectively reset the controller. Since you have programmed it with
>>> valid register values in the mean time it starts working after this
>>> reset."
>>>
>>> So do as suggested and force a reset of the LCDC hardware by
>>> enabling and disabling the IPG clock.
>>>
>>> With this change the Linux logo can be seen on boot on a mx25pdk.
>>>
>>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>>> ---
>>>  drivers/video/fbdev/imxfb.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>
>> Thanks. Queued for 4.5 fixes.
>=20
> Still don't see this one applied in Linus nor linux-next tree yet.

I've been a bit preoccupied, but I hope I get to send the pull request
today.

 Tomi


--xxoh6UFcJ1AkNsWwnu5QHSvo7xcOS63nU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvYzxAAoJEPo9qoy8lh71Rv0P/22iRnJvfimOvSjC0NgVaw2R
AB/GMS51BiHZQ2/7XRMWYXAUWEj+GQsNntQOiUOoGH9PURbJuwpwI3z5LWshEcwI
d8p6WXAsczOgYHiE6HGCbnEzICFpbvEgrmd1qe5fL5ya814sm9BEEupfP8zP7mLb
RYxzjdvC88kFRHneov1uqEzN6zjyTDhG1RLC5iebLUS/dEZSLTBUDvUujxgiZwYF
sTXEnnRhXJmp3ur+/luw5tWECGWEwkfAVEJQ+kaiiSJQHbhBlykT/MDCaCtq7IYS
mkAWb72aE6kOyTqSjHTgTy6BclfauLrBIc6Wy/S8r1IZMKD2Rssp20oMUI8Re5J0
vC4s0utznSgr/snFEeU8caOL6opnYFJRFZxyXTxtaxag0ug0RI3c/WsDcW2AadhD
VZOnJCjCCwCLXJij9otFkUjaagP3J+Lf5StHul3ICFphkUSOOOrS1iikdNV5TSA3
By3kN+6mw4IIlwPFpu9VA+3crq+SXB7ux1FREqIyIqTZxTkMpkS3RtZcG8J5PhXz
qMKOuCa4da10paf+IAEtUw/hUN0K6DdQ3Dh8t+FNxOdk4rfDIRylkSqBRs3tTkcN
K5KBWpCTFe8p9BMwkxqxhETUF88tsvRxrfymeM0Nlq9glgFCwj7VHYyUkLP+gNHZ
Rp4egRGx/9AiW1cvJZbh
=Bbp1
-----END PGP SIGNATURE-----

--xxoh6UFcJ1AkNsWwnu5QHSvo7xcOS63nU--
