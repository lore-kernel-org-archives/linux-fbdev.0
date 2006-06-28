From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] add framebuffer and display update
 module support for pnx4008
Date: Wed, 28 Jun 2006 17:07:45 +0800
Message-ID: <44A246E1.20801@gmail.com>
References: <20060627191747.4b455b24.vitalywool@gmail.com>	<44A1A2A6.5080206@gmail.com>
	<20060628114633.d96c8155.vitalywool@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvW1k-0001dF-6E for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 02:08:04 -0700
Received: from wx-out-0102.google.com ([66.249.82.207])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FvW1j-0004eY-Hg
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 02:08:04 -0700
Received: by wx-out-0102.google.com with SMTP id s19so1126058wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Jun 2006 02:08:02 -0700 (PDT)
In-Reply-To: <20060628114633.d96c8155.vitalywool@gmail.com>
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
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, gtolstolytkin@ru.mvista.com

Vitaly Wool wrote:
> On Wed, 28 Jun 2006 05:27:02 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>>> Index: linux-2.6.git/drivers/video/pnx4008/Makefile
>>> ===================================================================
>>> --- /dev/null
>>> +++ linux-2.6.git/drivers/video/pnx4008/Makefile
>>> @@ -0,0 +1,7 @@
>>> +#
>>> +# Makefile for the new PNX4008 framebuffer device driver
>>> +#
>>> +
>>> +obj-$(CONFIG_FB_PNX4008_DUM) += sdum.o
>>> +obj-$(CONFIG_FB_PNX4008_DUM_RGB) += rgbfb.o
>> rgbfb? Can the name be more descriptive of the chipset?
> 
> Hmmm, the thing is that the frambuffer can actually be anyone of a kind.
> Display Update Module provides interface to the actual device and the only difference it makes is whether it's a RGB or YUV framebuffer.
> 

Well, something like pnxrgbfb, pnxyuvfb? But it's your driver, so
your call.

>>> +
>>> +static int no_cursor(struct fb_info *info, struct fb_cursor *cursor)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>> Hmm, this driver is not going to be used as a console at all?
> 
> No, it was never planned to be.

Okay, but you can always give the user an option to turn it on, say,
with video=rgbfb:cursor boot/module parameter.

> 
>>> +config FB_PNX4008_DUM
>>> +	tristate "Display Update Module support on Philips PNX4008 board"
>>> +	depends on FB && ARCH_PNX4008
>>> +	---help---
>>> +	  Say Y here to enable support for PNX4008 Display Update Module (DUM)
>>> +
>>> +config FB_PNX4008_DUM_RGB
>>> +	tristate "RGB Framebuffer support on Philips PNX4008 board"
>>> +	depends on FB_PNX4008_DUM
>>> +	select FB_CFB_FILLRECT
>>> +	select FB_CFB_COPYAREA
>>> +	select FB_CFB_IMAGEBLIT
>>> +	---help---
>>> +	  Say Y here to enable support for PNX4008 RGB Framebuffer
>>> +
>> Are there other uses of the "Display Update Module" other than the framebuffer?
>> IOW, is CONFIG_PNX4008_DUM=y, CONFIG_PNX4008_DUM_RGB=n a usable configuration?
> 
> It is, but currently it will result in nothing shown on the LCD.
> However, it's planned to add YUV framebuffer driver which also requires DUM and is an alternative to RGB one.

Okay.

>  
>>> +int pnx4008_get_dum_channel_uf(struct dumchannel_uf *p_chan_uf, int dev_id)
>>> +{
>>> +	int i = p_chan_uf->channelnr;
>>> +
>>> +	if (i < 0 || i > MAX_DUM_CHANNELS)
>>> +		return -EINVAL;
>>> +	else if (dum_data.fb_owning_channel[i] != dev_id)
>>> +		return -EFBNOTOWNER;
>>> +	else {
>>> +		p_chan_uf->dirty = dum_data.chan_uf_store[i].dirty;
>>> +		p_chan_uf->source = dum_data.chan_uf_store[i].source;
>>> +		p_chan_uf->x_offset = dum_data.chan_uf_store[i].x_offset;
>>> +		p_chan_uf->y_offset = dum_data.chan_uf_store[i].y_offset;
>>> +		p_chan_uf->width = dum_data.chan_uf_store[i].width;
>>> +		p_chan_uf->height = dum_data.chan_uf_store[i].height;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +EXPORT_SYMBOL(pnx4008_get_dum_channel_uf);
>> Unused?
> 
> For this one and followers, they might be used in YUV framebuffer driver. However, if you consider it's reasonable to remove those for now, I don't mind.

You can just enclose then with an #if 0/#endif

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
