From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Date: Tue, 01 Sep 2020 08:44:35 +0000
Subject: Re: [PATCH v4] video: fbdev: ssd1307fb: Added support to Column offset
Message-Id: <d15729dd-63d1-7a06-f957-22eab6d74c9f@ysoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
In-Reply-To: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: b.zolnierkie@samsung.com
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>

On 24. 07. 20 22:22, Rodrigo Alencar wrote:
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.
>=20
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>

Hi Bartlomiej,
what is the status of this patch? I would like to see this merged so I=C2=
=A0can send
patches for our in-tree imx6dl-yapp4 device trees that need exactly this ch=
ange.

Thank you,
Michal
