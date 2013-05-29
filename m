From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Wed, 29 May 2013 16:18:39 +0000
Subject: Re: [PATCH 1/3] video: xilinxfb: Fix OF probing on little-endian systems
Message-Id: <fbca0735-c7df-4d44-a429-a2042ed6324a@CO9EHSMHS021.ehs.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <502367ddf6d79b7b343b3165ad54cb9e2d4713db.1369843969.git.michal.simek@xilinx.com>
In-Reply-To: <502367ddf6d79b7b343b3165ad54cb9e2d4713db.1369843969.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Pallav Joshi <pallav.joshi@xilinx.com>, git-dev@xilinx.com, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

On Wed, May 29, 2013 at 06:12:56PM +0200, Michal Simek wrote:
> From: Michal Simek <monstr@monstr.eu>
>=20
> DTB is always big-endian that's why is necessary
> to convert it.
>=20
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/video/xilinxfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index af0b4fd..5af341e 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -428,7 +428,7 @@ static int xilinxfb_of_probe(struct platform_device *=
op)
>  	 * interface and initialize the tft_access accordingly.
>  	 */
>  	p =3D (u32 *)of_get_property(op->dev.of_node, "xlnx,dcr-splb-slave-if",=
 NULL);
You should consider using 'of_property_read_u32() (or one of its other
variants for arrays, strings, etc). That already implicitly does the
endian conversion.

	S=C3=B6ren


