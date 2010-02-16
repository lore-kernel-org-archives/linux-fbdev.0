From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Tue, 16 Feb 2010 02:12:25 +0000
Subject: Re: [PATCH 1/10] udlfb: checkpatch cleanup
Message-Id: <45a44e481002151812u6bf3d6bewb04642c4ff42525e@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245143.4353.3288.camel@bernie-aspireone>
In-Reply-To: <1266245143.4353.3288.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Mon, Feb 15, 2010 at 10:45 PM, Bernie Thompson <bernie@plugable.com> wro=
te:
> =A0drivers/staging/udlfb/udlfb.c | =A0 74 +++++++++++++++++++------------=
-----------
>
> =A0static struct fb_fix_screeninfo dlfb_fix =3D {
> + =A0 =A0 =A0 .id =3D =A0 =A0 =A0 =A0 =A0 "displaylinkfb",

Just a quick note, I think udlfb.c should retain its udlfb id to avoid
confusion with displaylinkfb, which was/is a different driver.
