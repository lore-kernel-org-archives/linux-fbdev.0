From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: 2.5.14 oops in fb_copy_cmap
Date: Tue, 7 May 2002 11:02:53 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10205071102120.30751-100000@www.transvirtual.com>
References: <20020506170357.GA3798@kroah.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1759Iw-00057H-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 May 2002 11:03:14 -0700
In-Reply-To: <20020506170357.GA3798@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> I get the oops below at boot time if "vga=0x0305" is on the command
> line.  If I take it off, I can boot just fine.

Hm. Can you wait a few days. I'm porting the vesa driver to the new api. I
will soon release a new driver.


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
