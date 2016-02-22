From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Feb 2016 15:41:37 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56CB2C31.5040703@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2ARonUXH6IC3cCgeD5a84xSnXduRC8wLa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
 <20160217213250.GK19428@n2100.arm.linux.org.uk> <56C5B080.9090007@ti.com>
 <CACRpkdaXFUCR5=5mS28_4Dx_LfzqV13zwT=vVeJwuOzm_rGRBQ@mail.gmail.com>
In-Reply-To: <CACRpkdaXFUCR5=5mS28_4Dx_LfzqV13zwT=vVeJwuOzm_rGRBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--2ARonUXH6IC3cCgeD5a84xSnXduRC8wLa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/02/16 00:39, Linus Walleij wrote:
> On Thu, Feb 18, 2016 at 12:52 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>=20
>> For panels we need DT fragments. The question is where these fragments=

>> are and, possibly, who who loads them.
>=20
> I hacked something up that augments the device tree from the kernel,
> given you have a node with all the props you want to augment, tell me
> what you think of this and whether I should continue in this direction.=
=2E.
> also the DT people need to be involved:

What you have there is almost like a legacy board file, isn't it? It's
just passing DT data forward, instead of device platform data. In fact,
if the driver in question supports platform data too, you could as well
generate platform data for it (but I'm not saying that's a better option)=
=2E

After thinking this a bit and discussing it with Laurent P., generally
speaking I still think that the only sane option is that the bootloader
does any detection needed and provides the kernel a .dtb that contains
the HW that is connected. No board specific drivers are needed on the
kernel side.

In some cases userspace loaded DT overlays may be fine, if the userspace
can do the detection and the device in question is not somehow critical
to operation. But I think displays are critical, and afaik in Versatile
case the userspace can't even do the detection (?).

The third option is to have board specific display handling code and the
display HW data in the kernel, as you've done in the patches.

But, of course, which option should be used for which board is not
always clear...

What bootloader is used on Versatile? If it's some proprietary loader
which can't be changed, then the bootloader option is out, and I guess
it points to the third option, i.e. either the version in this patch or
the earlier version. If it's u-boot, I would suggest going for the
bootloader option.

Afaik u-boot doesn't support combining DT fragments yet. But (also
afaik) the u-boot maintainer is ok with the idea. And I know there are
others (for example TI) interested in the same functionality.

Now, adding that support might take some time, and in the meantime it'd
be good to get the HW working with kernel with a temporary solution. To
do that, my suggestion is basically "any solution which requires no
(temporary) changes to .dts".

While I don't like too much the solution in the patch here, it's all
inside kernel code and can be dropped easily, right? If we would merge
the the multi-endpoint solution you had in the earlier patch, you would
have to support that .dts in the future too.

 Tomi


--2ARonUXH6IC3cCgeD5a84xSnXduRC8wLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWyywxAAoJEPo9qoy8lh71g/MQAK4KebDkTAHQ6c+TmQ0f8tLA
G9F+zcBkqNlfMY0YFBVl3vM3duSV9r5JCz9Wo9MEAGLHjYpUBkyw6Rh67wETJffg
ujCiBGJsHjyFfFLl/g+24naaF2sSin8JJLt3p7znkxmkQo1grOkwSl7BAyuaMikX
lSR1IpTSnR3z+fkzewWwBG9Fdo8WT5behu4FYUj4J94628nPSJY/SqSrGITTmdm4
1gWGETcoQeUpFnDpl/bpJm0aVUl3p6HKmMmh6BDOq1xXF8B5YIQjyLw3pzQbUGH1
45Grkra4LQFWfSZhyH6mlSlqqlzgqo3oDdaBz/cMYg1EtbtQJrIoocYSUs8XY3wd
cLPGqC4rmQKKAr2o8kL/ED52r8K99lnt1Nq3QnjK61QJjWjuK1GPdVjqDzIiT82f
Cnq9aR2bCWy3kmnKSAOfFb/hqqskMrltRMycoFPXB+Nl5YjvraN+9ZTsdsLLUQTK
0HlhQ2kpoaucdJUwgMEaj4o3TgGyoziEZoU/1VR1Y0ZdXRe57gbVqqYQlFQmynI+
Kr3c0LWv2LxX75sGJMqNZ52fsB9Q3CnUm29VhAmurbkleZ3bs0CeDejXfco0hkxa
sac/uY9Cw+qD5gr8KyHHS5E6QF22Hhdi2mXGKEo896BAgQc7aQ6kG2vJ9OBbBAtf
3si4XRMMDHfByQmewcH6
=aa5t
-----END PGP SIGNATURE-----

--2ARonUXH6IC3cCgeD5a84xSnXduRC8wLa--
