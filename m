From: Antonino Daplas <adaplas@pol.net>
Subject: Re: gen_set_var() fix?
Date: 28 Aug 2002 17:03:26 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1030525403.632.7.camel@daplas>
References: <20020828100048.2dde942e.jani@iv.ro>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17jyjO-0002Fo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Aug 2002 02:03:18 -0700
In-Reply-To: <20020828100048.2dde942e.jani@iv.ro>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jani Monoses <jani@iv.ro>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2002-08-28 at 18:00, Jani Monoses wrote:
> James
> Should't gen_set_var set the var in info here as well? (when no check_var present)
> BTW is gen_set_var going to stay in the new API or go away ?
> 
> --- fbgen.c.orig       Wed Aug 28 09:49:45 2002
> +++ fbgen.c     Wed Aug 28 09:57:32 2002
> @@ -36,7 +36,7 @@
> 
>         if (con < 0 || (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo)))) {
>                 if (!info->fbops->fb_check_var) {
> -                       *var = info->var;
> +                       info->var = *var;
>                         return 0;
>                 }
> 
> 
The original code is correct.  It means the driver supports only 1 video
mode, which is the current one in info->var.  

Tony




-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
