From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: Mixing g400 dualhead and old Millennium.
Date: Sun, 13 Oct 2002 18:07:46 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021013160746.GA17618@casa.fluido.as>
References: <20021012153641.GA13798@casa.fluido.as> <20021013001324.GF4267@ppc.vc.cvut.cz> <20021013141516.GA9973@casa.fluido.as> <20021013145604.GC20348@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl ([62.163.205.17] helo=mail.fluido.as)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 180lHe-0002vX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 09:08:03 -0700
Content-Disposition: inline
In-Reply-To: <20021013145604.GC20348@ppc.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

	Subject: Re: Mixing g400 dualhead and old Millennium.
	Date: dom, ott 13, 2002 at 04:56:04 +0200

Quoting Petr Vandrovec (vandrove@vc.cvut.cz):

> If you could print return value from register_framebuffer in 
> matroxfb_dh_regit in matroxfb_crtc2.c, maybe it could reveal
> problem. Maybe that using non-ac kernel fixes problem too.

It never reaches register_framebuffer. It leaves dh_regit at tese
lines:

        else if (ACCESS_FBINFO(video.len) < mem) {
                kfree(d);
                return -ENOMEM;
        }

ACCESS_FBINFO(video.len) is 2097152. Mem is 8388608.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
