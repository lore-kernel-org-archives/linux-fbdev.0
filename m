From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] tdfxfb: hardware cursor
Date: Sat, 28 Jul 2007 17:22:17 +0800
Message-ID: <1185614537.9324.2.camel@daplas>
References: <20070728102635.d31fa8ea.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IEiVE-00061t-KM for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Jul 2007 02:22:24 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IEiVE-0002VI-4T
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Jul 2007 02:22:24 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1271731waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 28 Jul 2007 02:22:23 -0700 (PDT)
In-Reply-To: <20070728102635.d31fa8ea.krzysztof.h1@wp.pl>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, 2007-07-28 at 10:26 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch adds hardware cursor support to the tdfxfb driver.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> 
> This patch requires all tdfxfb patches from the -mm tree and the source code 
> improvement patch sent yesterday to this list.
> 
> I am not sure if the FB_CUR_SETIMAGE and FB_CUR_SETSHAPE are implemented
> correctly (the mask is always mask and the image is xor or and of the mask and data).
> The cursor works correctly on Voodoo3 2000 PCI with this patch.
> 
> I added a separate option to Kconfig to enable this feature but I am eager to remove
> the option and make the hardware cursor always used after someone can confirm
> it is ok on Banshee and Voodoo4/5 (no ifdefs).

I would rather that you make the hardware cursor support permanent
(instead of adding another Kconfig option) and just have a boot option
to enable/disable the hardware cursor.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
