From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: 2 more fbcon rotation bugs
Date: Fri, 18 Nov 2005 16:23:22 +0100
Message-ID: <437DF1EA.7010906@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed85R-0002NP-0q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 07:23:37 -0800
Received: from mailout09.sul.t-online.com ([194.25.134.84])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ed85P-0002rm-FW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 07:23:37 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Antonino,

For rotation values of 1 and 3 in combination with unusual font heights 
there are
serious cursor problems:

    standard 8x16 and arial 22x24: ok
    comic 16x26 and bitstream 16x30: broken as described below.

1: Load e.g. bitstream 16x30 font and switch to rotation 1.
2: At the bash prompt, type "asdf  > qwer" without the quotation marks 
and without
    hitting enter.
3: Try to delete the letters q,w,e,r and reenter them. Everything works 
fine.
4: Now place the cursor immediately behind the letter f and delete it. 
Everything ok.
5. Hit the key f to reenter that letter .... now something breaks:
    a: an f is inserted at the correct position
    b: an f flashes for a short period at the place of the first space, 
then it is overwritten
        by the correct space character and the blinking cursor
    c: the > at the right of the cursor is permanently overwritten with 
a blank and a
        frozen underline of the cursor, the line now reads asdf _ _ qwer.

Deleting and reinserting the other characters before the > gives similar 
results, e.g.
for the letter s the result is "asdd > qwer", the first d switching from 
s to d fast but
visible and with the blinking cursor, the 2nd d (that should be an f) 
permanently
underlined.

No problems are visible if only one string of letters (even a long one) 
is entered and
edited  at the bash prompt.

Any idea where to start? Can you reproduce the odd behaviour? My first 
idea was
to look into ccw_cursor() and cw_cursor(), but as there are no errors 
for long strings
if they do not contain spaces, > or other signs of a special meaning to 
bash, I suppose
that this is not the right/only place to start. My system is slow (Via 
Eden cpu, 533Mhz),
could it be that the bug is invisible on faster machines? ...

cu,
 Knut


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
