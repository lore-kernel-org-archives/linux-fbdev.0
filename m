From: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Subject: Re: New API: porting docs ?
Date: Tue, 8 Oct 2002 15:00:52 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021008130052.GA3913@iliana>
References: <20021006112909.30306@192.168.4.1> <1034019453.572.26.camel@daplas> <20021008113808.GA3390@iliana> <20021008150157.1b4b8a9d.jani@iv.ro> <20021008151604.0cc5933e.jani@iv.ro>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17ytqA-0004FR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 08 Oct 2002 05:51:58 -0700
Content-Disposition: inline
In-Reply-To: <20021008151604.0cc5933e.jani@iv.ro>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Monoses <jani@iv.ro>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, Oct 08, 2002 at 03:16:04PM +0000, Jani Monoses wrote:
> 
> > Attached is tridentfb which works for the new API but only with cfb accels
> > the native ones still need work.I'll send this in when that is fixed.
> > You can look at it or do a diff against original tridentfb in current 2.5
> > to see what's changed
> 
> forgot it

Mmm, just a quick question.

Is it better to keep the tridentfb.h in drivers/video like you do, or
move it to include/video as is done in tdfxfb ?

Friendly,

Sven Luther



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
