From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 01/11] fbcon: Kill compile warning
Date: Thu, 02 Aug 2007 09:23:02 +0800
Message-ID: <1186017782.4707.1.camel@daplas>
References: <46B03735.9020803@gmail.com>
	<20070801154143.613d83da.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGPP5-0006ou-FR for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 18:23:03 -0700
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IGPP3-0004Ft-M1
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 18:23:03 -0700
Received: by wa-out-1112.google.com with SMTP id k22so399284waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 01 Aug 2007 18:23:01 -0700 (PDT)
In-Reply-To: <20070801154143.613d83da.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2007-08-01 at 15:41 -0700, Andrew Morton wrote:
> On Wed, 01 Aug 2007 15:33:09 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
> > +static inline void fbcon_map_override(void)
> > +{
> > +	map_override = 1;
> > +}
> > +#else
> > +#define fbcon_map_override(...) do { } while (0)
> > +#endif /* CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY */
> 
> It's odd to use a C function in one case and a macro in the other.
> Was there a reason to not use plain old static inline?

No reason, an empty inline function is fine with me too.

Tony


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
