From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: Another problem, seemingly coming f
Date: Wed, 16 Oct 2002 12:16:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021016101630.GA29402@casa.fluido.as>
References: <4BECCE234BB@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl ([62.163.205.17] helo=mail.fluido.as)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181lEH-00057l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 03:16:41 -0700
Content-Disposition: inline
In-Reply-To: <4BECCE234BB@vcnet.vc.cvut.cz>
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
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, gif@bek.no

	Subject: Re: [Linux-fbdev-devel] Another problem, seemingly coming f
	Date: mer, ott 16, 2002 at 09:00:27 +0200

Quoting Petr Vandrovec (VANDROVE@vc.cvut.cz):

> Ah, these ones... What pixclocks do you use? It is like if CRTC2 has
> not enough memory bandwidth available, and so it displays stale data.
> But it looks strange anyway. I'm afraid that I cannot help you,
> sorry. You can try experimenting with different pixclocks, different
> bit depths, and so on. But I cannot explain why it happens only
> when old Millennium is also in the box.

I was able to reduce video artifacts to a minimum (seemingly
acceptable ;-) by setting 

- millennium to 800x600-60
- G400 1st head to 800x600-90
- G400 2nd head to 800x600-75

These are standard framebuffer modes found in /etc/fb.modes. I am
getting most artifacts when setting both heads of the G400 to the same
fb mode - which one does not influence things too much.

Thanks for your help

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
