From: Chad A Daelhousen <cd9@cse.Buffalo.EDU>
Subject: Re: radeonfb + RV200 + DVI broken [2.4 ONLY]
Date: Tue, 10 Jun 2003 12:34:28 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030610163428.GA17059@gagarin.cse.Buffalo.EDU>
References: <20030605233638.GA9842@gagarin.cse.Buffalo.EDU>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from gagarin.cse.buffalo.edu ([128.205.36.11] ident=daemon)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Pm4x-00086A-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Jun 2003 09:34:35 -0700
Received: (from cd9@localhost)
	by gagarin.cse.buffalo.edu (8.11.6+Sun/8.11.6) id h5AGYS817068
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Jun 2003 12:34:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20030605233638.GA9842@gagarin.cse.Buffalo.EDU>
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
To: linux-fbdev-devel@lists.sourceforge.net

At Thu, Jun 05, 2003 at 07:36:38PM -0400, Chad A Daelhousen wrote:
> Incidentally, I tried this on 2.5.68 as well; it simply ignores
> panel_yres, detects the panel as being 1x0, and doesn't change the video
> mode.

I did that too hastily, missing the radeon to radeonfb change in the
video= option. video=radeonfb:1280x1024@61,panel_yres:1024 works
beautifully in 2.5.70. Thank you.

Has anyone backported this fix to 2.4?

-- 
Chad Daelhousen
My opinions are my own, until UB purchases my soul.


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
