From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Mon, 08 Oct 2018 21:59:30 +0000
Subject: Re: [PATCH v4 02/11] gpu: ipu-csi: Swap fields according to input/output field types
Message-Id: <e2ae98c2-a6a3-19b9-bd85-664e5f80c4ab@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
 <20181004185401.15751-3-slongerbeam@gmail.com>
 <1538732679.3545.5.camel@pengutronix.de>
In-Reply-To: <1538732679.3545.5.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM DRIVERS FOR FREESCALE IMX" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

Hi Philipp,


On 10/05/2018 02:44 AM, Philipp Zabel wrote:
> Hi Steve,
>
> On Thu, 2018-10-04 at 11:53 -0700, Steve Longerbeam wrote:
>
>
>> +
>> +		/* framelines for NTSC / PAL */
>> +		height =3D (std & V4L2_STD_525_60) ? 525 : 625;
> I think this is a bit convoluted. Instead of initializing std, then
> possibly changing it, and then comparing to the inital value,=C2=A0and th=
en
> checking it again to determine the new height, why not just:
>
> 		if (width =3D 720 && height =3D 480) {
> 			std =3D V4L2_STD_NTSC;
> 			height =3D 525;
> 		} else if (width =3D 720 && height =3D 576) {
> 			std =3D V4L2_STD_PAL;
> 			height =3D 625;
> 		} else {
> 			dev_err(csi->ipu->dev,
> 				"Unsupported interlaced video mode\n");
> 			ret =3D -EINVAL;
> 			goto out_unlock;
> 		}
>
> ?

Yes that was a bit convoluted, fixed.

>
>>  =20
>>   	/*
>>   	 * if cycles is set, we need to handle this over multiple cycles as
>>   	 * generic/bayer data
>>   	 */
>> -	if (is_parallel_bus(&priv->upstream_ep) && incc->cycles) {
>> -		if_fmt.width *=3D incc->cycles;
> If the input format width passed to ipu_csi_init_interface is not
> multiplied by the number of cycles per pixel anymore, width in the
> CSI_SENS_FRM_SIZE register will be set to the unmultiplied value from
> infmt.
> This breaks 779680e2e793 ("media: imx: add support for RGB565_2X8 on
> parallel bus").

Oops, that was a mistake, thanks for catching, fixed.

Steve
