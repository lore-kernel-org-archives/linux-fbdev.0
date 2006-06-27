From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] add framebuffer and display update
 module support for pnx4008
Date: Wed, 28 Jun 2006 05:27:02 +0800
Message-ID: <44A1A2A6.5080206@gmail.com>
References: <20060627191747.4b455b24.vitalywool@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvL5d-00071I-18 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 14:27:21 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FvL5c-0000ax-DO
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 14:27:21 -0700
Received: by py-out-1112.google.com with SMTP id t32so2134809pyc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 27 Jun 2006 14:27:19 -0700 (PDT)
In-Reply-To: <20060627191747.4b455b24.vitalywool@gmail.com>
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
Cc: Grigory Tolstolytkin <gtolstolytkin@ru.mvista.com>

Vitaly Wool wrote:
> Hi folks,
> 
> inlined is the patch that adds support for Display Update Module and RGB framebuffer device on Philips PNX4008 ARM board.
> 
>  Kconfig            |   15
>  Makefile           |    2
>  pnx4008/Makefile   |    7
>  pnx4008/dum.h      |  243 ++++++++++++++
>  pnx4008/fbcommon.h |   43 ++
>  pnx4008/rgbfb.c    |  223 +++++++++++++
>  pnx4008/sdum.c     |  866 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  pnx4008/sdum.h     |  139 ++++++++
>  8 files changed, 1538 insertions(+)
> 
> Signed-off-by: Grigory Tolstolytkin <gtolstolytkin@ru.mvista.com>
> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
> 
> Index: linux-2.6.git/drivers/video/pnx4008/Makefile
> ===================================================================
> --- /dev/null
> +++ linux-2.6.git/drivers/video/pnx4008/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the new PNX4008 framebuffer device driver
> +#
> +
> +obj-$(CONFIG_FB_PNX4008_DUM) += sdum.o
> +obj-$(CONFIG_FB_PNX4008_DUM_RGB) += rgbfb.o

rgbfb? Can the name be more descriptive of the chipset?


> +
> +static int no_cursor(struct fb_info *info, struct fb_cursor *cursor)
> +{
> +	return 0;
> +}
> +

Hmm, this driver is not going to be used as a console at all?

> +
> +static int rgbfb_open(struct fb_info *info, int user)
> +{
> +	return 0;
> +}
> +
> +static int rgbfb_release(struct fb_info *info, int user)
> +{
> +	return 0;
> +}
> +

Just remove fb_open() nad fb_release().

> +static int __devinit rgbfb_probe(struct platform_device *pdev)
> +{
> +	struct fb_info *info;
> +	struct dumchannel_uf chan_uf;
> +	int ret;
> +
> +	info = framebuffer_alloc(sizeof(u32) * 256, &pdev->dev);

256 is too much. You can use 16.

> +	return 0;
> +
> +err2:
> +	fb_dealloc_cmap(&info->cmap);
> +err1:
> +	framebuffer_release(info);
> +err:
> +	pnx4008_free_dum_channel(channel_owned, pdev->id);

Check the error path. This driver may leak resources.

>  
> +config FB_PNX4008_DUM
> +	tristate "Display Update Module support on Philips PNX4008 board"
> +	depends on FB && ARCH_PNX4008
> +	---help---
> +	  Say Y here to enable support for PNX4008 Display Update Module (DUM)
> +
> +config FB_PNX4008_DUM_RGB
> +	tristate "RGB Framebuffer support on Philips PNX4008 board"
> +	depends on FB_PNX4008_DUM
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	---help---
> +	  Say Y here to enable support for PNX4008 RGB Framebuffer
> +

Are there other uses of the "Display Update Module" other than the framebuffer?
IOW, is CONFIG_PNX4008_DUM=y, CONFIG_PNX4008_DUM_RGB=n a usable configuration?


> +int pnx4008_get_dum_channel_uf(struct dumchannel_uf *p_chan_uf, int dev_id)
> +{
> +	int i = p_chan_uf->channelnr;
> +
> +	if (i < 0 || i > MAX_DUM_CHANNELS)
> +		return -EINVAL;
> +	else if (dum_data.fb_owning_channel[i] != dev_id)
> +		return -EFBNOTOWNER;
> +	else {
> +		p_chan_uf->dirty = dum_data.chan_uf_store[i].dirty;
> +		p_chan_uf->source = dum_data.chan_uf_store[i].source;
> +		p_chan_uf->x_offset = dum_data.chan_uf_store[i].x_offset;
> +		p_chan_uf->y_offset = dum_data.chan_uf_store[i].y_offset;
> +		p_chan_uf->width = dum_data.chan_uf_store[i].width;
> +		p_chan_uf->height = dum_data.chan_uf_store[i].height;
> +	}
> +
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL(pnx4008_get_dum_channel_uf);

Unused?

> +
> +int pnx4008_get_dum_channel_config(int channr, int dev_id)
> +{
> +	int ret;
> +	struct dumchannel chan;
> +
> +	if (channr < 0 || channr > MAX_DUM_CHANNELS)
> +		return -EINVAL;
> +	else if (dum_data.fb_owning_channel[channr] != dev_id)
> +		return -EFBNOTOWNER;
> +	else {
> +		chan.channelnr = channr;
> +		if ((ret = get_channel(&chan)) != 0)
> +			return ret;
> +	}
> +
> +	return (chan.dum_ch_conf & DUM_CHANNEL_CFG_MASK);
> +}
> +
> +EXPORT_SYMBOL(pnx4008_get_dum_channel_config);

Unused?

> +int pnx4008_set_dum_chanel_dirty_detect(int channr, int val, int dev_id)
> +{
> +	if (channr < 0 || channr > MAX_DUM_CHANNELS)
> +		return -EINVAL;
> +	else if (dum_data.fb_owning_channel[channr] != dev_id)
> +		return -EFBNOTOWNER;
> +	else {
> +		if (val == CONF_DIRTYDETECTION_ON)
> +			DUM_CH_CONF(channr) |= CONF_DIRTYENABLE;
> +		else if (val == CONF_DIRTYDETECTION_OFF)
> +			DUM_CH_CONF(channr) &= ~CONF_DIRTYENABLE;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL(pnx4008_set_dum_chanel_dirty_detect);
                                 ^^^^^^       
channel?

> +
> +int pnx4008_force_update_dum_channel(int channr, int dev_id)
> +{
> +	if (channr < 0 || channr > MAX_DUM_CHANNELS)
> +		return -EINVAL;
> +
> +	else if (dum_data.fb_owning_channel[channr] != dev_id)
> +		return -EFBNOTOWNER;
> +	else
> +		DUM_CH_CTRL(channr) = CTRL_SETDIRTY;
> +
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL(pnx4008_force_update_dum_channel);

Unused?

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
