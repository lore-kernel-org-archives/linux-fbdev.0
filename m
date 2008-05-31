From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 1/5] pxafb: module
	unloading support
Date: Sat, 31 May 2008 03:20:17 -0400
Message-ID: <45a44e480805310020s59ea8278yb5b707344bda64e2@mail.gmail.com>
References: <1212208915-24544-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212208915-24544-2-git-send-email-jayakumar.lkml@gmail.com>
	<20080531084346.30ca0f2a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2LNz-0003Rw-Ae for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 May 2008 00:20:25 -0700
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2LNx-0006jo-S3
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 May 2008 00:20:19 -0700
Received: by wf-out-1314.google.com with SMTP id 27so152191wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 31 May 2008 00:20:17 -0700 (PDT)
In-Reply-To: <20080531084346.30ca0f2a.krzysztof.h1@poczta.fm>
Content-Disposition: inline
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, May 31, 2008 at 2:43 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
>
> The best solution is to leave it as __devinitdata as it is accessed only by __init
> and __devinit functions.
> Your previous error was to change the functions to __devinit while changing
> the g_options to __initdata.
>

Ok, understood, I'll leave it as __devinitdata.

While we are on this subject of fbdev options parsing, I think we
should just use the standard module.option = value parameters rather
than doing parsing. Is there consensus in fbdev that we should
deprecate the options parsing stuff? If so, should we start warning
users that the option parsing code will go away? Something like:

int fb_get_options(char *name, char **option)
{
        char *opt, *options = NULL;
        int opt_len, retval = 0;
        int name_len = strlen(name), i;

        pr_warning("Please use module.option = value. The
video=module:options mechanism will be removed in June 2009");
...

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
