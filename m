From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Comments on fbgen.c and fbcon-accel.c
Date: Fri, 31 May 2002 13:45:04 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0205311343570.3190-100000@www.transvirtual.com>
References: <1020535355.797.0.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DtGp-0007ZT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 May 2002 13:45:11 -0700
In-Reply-To: <1020535355.797.0.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


> The above is fine if everything is done in the console.  However,
> problems may arise if an app that touches the graphics hardware (ie X)
> is launched.  From the point of view of fbcon, the hardware state hasn't
> changed (compare of newvar with oldvar is false) when display is
> switched back to console.  And if that app did not fully restore the
> hardware state,  we will be left with a corrupted display.

I'm aware of this flaw. I plan to fix this when the rewrite of the console
system starts. The console system should handle restore ths video mode.


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
