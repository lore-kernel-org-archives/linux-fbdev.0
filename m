From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Re: [BK FBDEV] String drawing optim
Date: Fri, 16 May 2003 18:45:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1AFB79A034C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19GiLh-0003Xf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 16 May 2003 09:46:25 -0700
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jsimmons@infradead.org

On 16 May 03 at 10:24, Geert Uytterhoeven wrote:
> On Thu, 15 May 2003, James Simmons wrote:
> > > What about getting rid of one-char putc, implementing it in terms of
> > > putcs? I'm doing it in matroxfb patches, and nobody complained yet, and
> > > with current length of {fbcon,accel}_putc{s,} I was not able to find
> > > measurable speed difference between putc and putc through putcs variants.
> > 
> > Hm. I compressed all the image drawing functions into accel_putcs which is 
> > used in many places. I then placed accel_putc() into fbcon_putc(). I could 
> > have accel_putcs() called in fbcon_putc(). The advantage is smaller 
> > amount of code. The offset is a big more overhead plus a function call. 
> > What do people think here?
> 
> putc() is almost never called, IIRC. We did our best to combine as much data as
> possible and call putcs().
> 
> A quick grep showed ->con_putc() is called only in drivers/char/vt.c for:
>   - Complementing the pointer position (for gpm)
>   - Inserting/deleting single characters
>   - Softcursor

Insert and Delete char are especially funny, as they do:

scr_memsetw(p, video_erase_char, nr * 2);
...
attr = video_erase_char >> 8;
while (nr--) {
   sw->con_putc(vc_cons[currcons].d,
                video_erase_char, y,
                video_num_columns-1-nr);
}
attr = oldattr;

so we can turn whole loop into one single putcs() call, asking
for painting 'nr' characters from 'p' at y,video_num_columns-nr, 
which will definitely help... And I believe that vc's attr is not 
used by putc/putcs anymore, we always pass color explicit (in upper 
bits of character).
                                                    Petr Vandrovec
                                                    



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
