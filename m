From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: dirty artefacts on bootup
Date: Wed, 07 Dec 2005 08:05:12 +1100
Message-ID: <1133903112.7168.50.camel@gaston>
References: <1133871927.5595.8.camel@noti>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ejk7v-0007PE-9s
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Dec 2005 13:13:31 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Ejk7t-0003hd-JD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Dec 2005 13:13:31 -0800
In-Reply-To: <1133871927.5595.8.camel@noti>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Dirk Henning Gerdes <mail@dirk-gerdes.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, 2005-12-06 at 13:25 +0100, Dirk Henning Gerdes wrote:
> Hi Benjamin,
> 
> I'm using the radeon framebuffer driver on a sony-notebook with a radeon
> 9200 mobile.
> 
> During bootup I get dirty artefacts on the screen. 
> It's hard to explain. The text first is clear on the screen, but then
> there come so many dirty lines on top of it, that you cannot read
> anything.
> When the xserver is started, the problem is away. switching to a console
> with [Alt][CTRL][F1] works perfectly. And then you can read the text
> normally.
> 
> I have compiled the driver with the debug-option, which brought the
> following output.
> I'm not quite sur, if this can help, because I got it, when the console
> worked after starting X.
> 
> [  148.839846] hStart = 1040, hEnd = 1176, hTotal = 1344
> [  148.839851] vStart = 770, vEnd = 776, vTotal = 806
> [  148.839855] h_total_disp = 0x7f00ync_strt_wid = 0x11040a
> [  148.839858] v_total_disp = 0x2ff0325noti login: [  148.839846] hStart
> = 1040, hEnd = 1176, hTotal = 1344
> [  148.839851] vStart = 770, vEnd = 776, vTotal = 806
> [  148.839855] h_total_disp = 0x7f00a7ync_strt_wid = 0x60301
> [  148.839860] pixclock = 15384
> [  148.839862] freq = 6500
> 
> Is there anything I can do to get this dirty lines away?

Not sure yet. It seems to only happen on machine I have no access to, so
I haven't been able to properly figure it out at this point.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
