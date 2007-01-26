From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Fri, 26 Jan 2007 15:56:58 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701261535180.30062@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<200701260513.24010.arnd@arndb.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HASVq-00078T-8h for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 06:57:10 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HASVn-0006uV-Qw
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 26 Jan 2007 06:57:10 -0800
In-Reply-To: <200701260513.24010.arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Paul Mackerras <paulus@samba.org>

On Fri, 26 Jan 2007, Arnd Bergmann wrote:
> > +} video_mode_table[] = {
> > +	{     0, }, /* auto */
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480I,       A_N,  720,  480, 1, 60},
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_480P,       A_N,  720,  480, 0, 60},
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_60HZ,  A_N, 1280,  720, 0, 60},
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_60HZ, A_W, 1920, 1080, 1, 60},
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_60HZ, A_W, 1920, 1080, 0, 60},
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576I,       A_N,  720,  576, 1, 50},
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_576P,       A_N,  720,  576, 0, 50},
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_720P_50HZ,  A_N, 1280,  720, 0, 50},
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080I_50HZ, A_W, 1920, 1080, 1, 50},
> > +	{YUV444, XRGB, PS3AV_CMD_VIDEO_VID_1080P_50HZ, A_W, 1920, 1080, 0, 50},
> > +	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_WXGA,       A_W, 1280,  768, 0, 60},
> > +	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_SXGA,       A_N, 1280, 1024, 0, 60},
> > +	{  RGB8, XRGB, PS3AV_CMD_VIDEO_VID_WUXGA,      A_W, 1920, 1200, 0, 60},
> > +};
> 
> Is there a fundamental reason why 1280x768 is not supported as YUV? That is
> the resolution that my TV set at home has natively, and I'd like to use it.

Analog YUV (Component and composite/S-video) video timings are dictated by
broadcast standards.

The last 3 resolutions are supported through the HDMI output only. Hence if
your TV has HDMI or DVI-D (_with_ HDCP, else you get a black screen) inputs,
you can use 1280x768.

If your TV doesn't have HDMI or DVI-D with HDCP, but it has component inputs,
you can use analog 720p.

> > +	msleep(100);
> > +
> > +	/* video mute on */
> > +	for (i = 0; i < num_of_av_port; i++) {
> > +		res = ps3av_cmd_av_video_disable_sig(ps3av.av_port[i]);
> > +		if (res < 0)
> > +			return -1;
> > +		if (i < num_of_hdmi_port) {
> > +			res = ps3av_cmd_av_tv_mute(ps3av.av_port[i],
> > +						   PS3AV_CMD_MUTE_OFF);
> > +			if (res < 0)
> > +				return -1;
> > +		}
> > +	}
> > +	msleep(300);
> 
> 400 ms total wait time is very noticeable to the user. Is it possible to
> reduce that time?
> 
> > +
> > +	msleep(1500);
> > +	/* av video mute */
> > +	ps3av_set_av_video_mute(PS3AV_CMD_MUTE_OFF);
> 
> This is an even longer time to wait for. What about this one?

Reducing these values may cause video noise to be seen when changing video
modes.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
