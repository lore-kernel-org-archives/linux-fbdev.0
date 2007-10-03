From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/17] ps3av: add quirk database for
	broken monitors
Date: Wed, 3 Oct 2007 14:00:54 -0700
Message-ID: <20071003140054.b340fe1f.akpm@linux-foundation.org>
References: <46FDACBE.8080707@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IdBL4-0004pN-TN for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Oct 2007 14:01:03 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IdBL4-0000SO-IF
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Oct 2007 14:01:02 -0700
In-Reply-To: <46FDACBE.8080707@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Geert.Uytterhoeven@sonycom.com, linux-fbdev-devel@lists.sourceforge.net

On Sat, 29 Sep 2007 09:39:10 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> +static const struct ps3av_monitor_quirk {
> +	const char *monitor_name;
> +	u32 clear_60, clear_50, clear_vesa;
> +} ps3av_monitor_quirks[] = {
> +	{
> +		.monitor_name	= "DELL 2007WFP",
> +		.clear_60	= PS3AV_RESBIT_1920x1080I
> +	}, {
> +		.monitor_name	= "L226WTQ",
> +		.clear_60	= PS3AV_RESBIT_1920x1080I |
> +				  PS3AV_RESBIT_1920x1080P
> +	}, {
> +		.monitor_name	= "SyncMaster",
> +		.clear_60	= PS3AV_RESBIT_1920x1080I
> +	}
> +};

One assumes that the presently-unused clear_50 and clear_vesa will
be used at some time in the future...

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
