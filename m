From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2 more fbcon rotation bugs
Date: Sat, 19 Nov 2005 04:23:50 +0800
Message-ID: <437E3856.9030509@gmail.com>
References: <437DF1EA.7010906@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdCmN-00087O-Gl
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 12:24:15 -0800
Received: from zproxy.gmail.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdCmN-0003re-2L
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Nov 2005 12:24:15 -0800
Received: by zproxy.gmail.com with SMTP id r28so284007nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Nov 2005 12:24:11 -0800 (PST)
In-Reply-To: <437DF1EA.7010906@t-online.de>
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
Content-Type: text/plain; charset="us-ascii"
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Knut Petersen wrote:
> Hi Antonino,
> 
> For rotation values of 1 and 3 in combination with unusual font heights
> there are
> serious cursor problems:
> 
>    standard 8x16 and arial 22x24: ok
>    comic 16x26 and bitstream 16x30: broken as described below.
> 
> 1: Load e.g. bitstream 16x30 font and switch to rotation 1.
> 2: At the bash prompt, type "asdf  > qwer" without the quotation marks
> and without
>    hitting enter.
> 3: Try to delete the letters q,w,e,r and reenter them. Everything works
> fine.
> 4: Now place the cursor immediately behind the letter f and delete it.
> Everything ok.
> 5. Hit the key f to reenter that letter .... now something breaks:
>    a: an f is inserted at the correct position
>    b: an f flashes for a short period at the place of the first space,
> then it is overwritten
>        by the correct space character and the blinking cursor
>    c: the > at the right of the cursor is permanently overwritten with a
> blank and a
>        frozen underline of the cursor, the line now reads asdf _ _ qwer.
> 
> Deleting and reinserting the other characters before the > gives similar
> results, e.g.
> for the letter s the result is "asdd > qwer", the first d switching from
> s to d fast but
> visible and with the blinking cursor, the 2nd d (that should be an f)
> permanently
> underlined.
> 
> No problems are visible if only one string of letters (even a long one)
> is entered and
> edited  at the bash prompt.
> 
> Any idea where to start? Can you reproduce the odd behaviour?

This one I cannot reproduce. Have you tried reproducing it with vesafb?
Any message in the log, such as a kernel oops?  Your description sounds
like a corruption of cursor->mask and cursor->image.data.

> My first
> idea was
> to look into ccw_cursor() and cw_cursor(), but as there are no errors
> for long strings
> if they do not contain spaces, > or other signs of a special meaning to
> bash, I suppose
> that this is not the right/only place to start. My system is slow (Via
> Eden cpu, 533Mhz),
> could it be that the bug is invisible on faster machines? ...

You can also try enabling a non-blinking block cursor
(Documentation/VGA-softcursor.txt) to isolate the problem. With a
non-blinking block cursor, fbcon's cursor is disabled and vt.c's softcursor
takes over.  

You also said that the cursor becomes fixed.  You can comment out the call
to ops->cursor in fb_flashcursor in fbcon.c so you get a fixed cursor and
eliminate the cursor blink pathway from the debugging.

Tony


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
