From: Antonino Daplas <adaplas@pol.net>
Subject: Problem with cfb_imageblit
Date: 24 May 2002 21:19:09 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1022214909.540.1.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17BExN-0008Ip-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 May 2002 06:18:09 -0700
Received: from [205.136.61.30] (cwc30.compass.com.ph [205.136.61.30])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id VAA07138
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 May 2002 21:17:59 +0800 (PHT)
	(envelope-from adaplas@pol.net)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I have an unusual problem with cfb_imageblit.  I'm not too sure if this
is unique to my system. I get garbage pixels.  For example the
underscore character (_) appears like this magnified:

   01234567
0
.
.
.

13  *******
14 *
15    **      <-- belongs to apostrophe char

It seems that the image is off by one bit and one row of pixels so it
also includes the first row of pixels of the next character (`) in
fontdata.

Looking at the code in cfbimgblt.c, I cannot find any obvious mistake,
so I made a dump of the variables during the loop iteration.  Here's
what I get:

/* bpp = 8, 8x16 font, caret (^) bitmap */

pad 0                  /* no excess pixels        */
10                     /* initial content of *src */
i 0, j 2, k 4, l 7
i 0, j 2, k 3, l 6
i 0, j 2, k 2, l 5
i 0, j 2, k 1, l 4
i 0, j 1, k 4, l 3
i 0, j 1, k 3, l 2
i 0, j 1, k 2, l 1
i 0, j 1, k 1, l 0     /* everything is okay until  ...         */  
38 l 7                 /* l = 7, and new content of *src = 0x38 */
i 1, j 2, k 4, l 0  <--- l = 0?!?!  I'm confused here ... 
6c l 7                 /* so, src is again updated (*src = 0x6c)*/
i 1, j 2, k 3, l 7     /* at this point, we're off by 9 bits    */
i 1, j 2, k 2, l 6
i 1, j 2, k 1, l 5
i 1, j 1, k 4, l 4
i 1, j 1, k 3, l 3
i 1, j 1, k 2, l 2
i 1, j 1, k 1, l 1
i 2, j 2, k 4, l 0     
c6 l 7
i 2, j 2, k 3, l 7     /* the algo is now doing what it should  */ 
i 2, j 2, k 2, l 6     /* and continues to do so till the end   */
i 2, j 2, k 1, l 5
i 2, j 1, k 4, l 4
i 2, j 1, k 3, l 3
i 2, j 1, k 2, l 2
i 2, j 1, k 1, l 1
i 3, j 2, k 4, l 0
0 l 7
<<< cut >>>

I'm not too sure why 'l' did not retain it's assignment. This happens
only after the first iteration of 'i'. I've tried using different
compilers (gcc-2.95.3 and gcc-3.0.4).  I've changed the declaration of
'l' to static and volatile, and changed its placement, but I still get
the same result. 

Just to prove that cfb_imageblit is correct, I used 'k' and 'j' instead
of 'l' in the test_bit() part.  It's slower, but it proves that the
algorithm of cfb_imageblit is correct.

for (i = 0; i < image->height; i++) {
   dst = (unsigned long *) dst1;
   for (j = image->width/ppw; j > 0; j--) {
      mask = 0;
      for (k = ppw; k > 0; k--) {	
        if (test_bit((j*ppw - (ppw-k) - 1), src))
           mask |= (tmp >> (p->var.bits_per_pixel*(k-1)));
     }
     fb_writel((mask & eorx)^bgx, dst); 
     dst++;
  }
  src++;
  l =- pad;		
  dst1 += p->fix.line_length;	
}	


Any comments?

Tony





_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
