From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: video dir reorg
Date: Tue, 14 Jan 2003 22:26:47 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030114212646.GA3731@iliana>
References: <20030114091308.GA17392@iliana> <20030114172236.69468.qmail@web14905.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YYaF-0002JO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 13:26:56 -0800
Content-Disposition: inline
In-Reply-To: <20030114172236.69468.qmail@web14905.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Jan 14, 2003 at 09:22:36AM -0800, Jon Smirl wrote:
> --- Sven Luther <luther@dpt-info.u-strasbg.fr> wrote:
> > I think Linus rejected this last time James
> > submitted it.
> 
> Didn't the last patch just move the DRM directory from
> driver/char into the video directory.?

There is a response of linus in the mailing list archive about this, i
don't remember nor checked if it was only the first time, or not. I
think the objection was about complicate to supervise diffs.

> This could be done in two steps. First split out the
> fb console driver files into their own directory and
> then sort out the hardware drivers more. Then if the
> DRM merge gets ok'd everything will be ready.
> 
> In the config system I don't like how you have to
> enable driver support for the same piece of hardware
> in two different places. I also don't like looking in
> two different places for the source to drivers for the
> same hardware.
> 
> What is Linus' take on merging a card's fb and drm
> drivers into a single module in the long run?

Well, the problem is that the fb drivers are maintained by us, and the
drm drivers are maintained by the DRI.

Also, i think the drm drivers should compile not only on linux, but on
other oses too (BSDs at least).

Also, i believe some of the XFree86 guys don't like fbdevs.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
