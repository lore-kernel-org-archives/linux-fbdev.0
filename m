From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: 3dfx framebuffer driver borked in 2.5.19 kernel
Date: Thu, 30 May 2002 11:40:14 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205301139260.9282-100000@www.transvirtual.com>
References: <20020530165031.GA18544@kira.glasswings.com.au>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020530165031.GA18544@kira.glasswings.com.au>
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
To: Andrew Pam <xanni@glasswings.com.au>
Cc: Hannu Mallat <hmallat@cc.hut.fi>, James Simmons <jsimmons@users.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> With the port to the new fbdev interface in kernel
> 2.5.19 the system now only displays a few unchanging coloured pixels
> on the first line of the screen.  The rest of the screen remains black
> until X11 starts.  I am using append="video=tdfx:1024x768" in LILO.

I'm tracking down the bug you are experiencing. Almost done. 


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
