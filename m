From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: writing to a floating point register ?
Date: Wed, 5 Feb 2003 13:04:58 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030205120458.GA1428@iliana>
References: <20030205103837.GA817@iliana> <Pine.GSO.4.21.0302051140460.16681-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gOIk-0005tD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 04:05:14 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0302051140460.16681-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Feb 05, 2003 at 11:44:23AM +0100, Geert Uytterhoeven wrote:
> 
> Even if you could, it would work for 32-bit IEEE floating point format only.
> Is the hardware register format IEEE compatible.


Something like this :

unsigned long cfp32(unsigned long v, unsigned long d) {
        unsigned int x, vx, m, e;
        for (x=0, vx=v; vx>1; x++, vx>>=1);
        m = (x>22?v>>(x-22):v<<(22-x)) & 0x007fffff;
        e = ((x+127-d)<<23) & 0x7f800000;
        return (e | m);
}

Does the job. I don't really test for exponent overflow, but well,
anyone trying a video mode whose exponent is greater than 127 deserves
what gets.

Are there any other subtle things that may break with the above ?

Anyway thanks for your help.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
