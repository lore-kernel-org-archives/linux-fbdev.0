From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: cursor maddnes and a solution
Date: Wed, 10 Aug 2005 14:14:54 +0800
Message-ID: <42F99B5E.1070309@gmail.com>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2js6-0007Ad-Ao
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 23:15:26 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2js5-0000sc-KS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Aug 2005 23:15:26 -0700
Received: by wproxy.gmail.com with SMTP id i21so62085wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Aug 2005 23:15:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>

James Simmons wrote:
> I still refuse to touch all drivers at a time. Instead I will merge in 

Why not?  The change is simple, logical and any bugs are easy to spot.

> soft_cursor into the internals of the fbcon cursor code. This will make 

The patch does that already. It's moving softcursor away from fbdev into
fbcon.

> soft cursor be longer used. Then we can remove the soft cursor from the
> drivers.

Yep, the patch does that too.

So, if I distill your arguments, it boils down to that your main concern is
the patch touches all drivers at once.  So you want 1 patch per driver
then? But Documentation/SubmittingPatches says:

	"On the other hand, if you make a single change to numerous files,
	 group those changes into a single patch.  Thus a single logical change
	 is contained within a single patch."

In the end, it seems that you, me and Jon have the same goal in mind. I don't
see any disagreement here.

>There will be no soft_cursor wrap around to imageb lit anymore.
> I think people can live with that.

And how do you propose to implement a softcursor that is not a wrapper to
imageblit?  Using fillrect?  That's fine with me. Just take into consideration
that an XOR Rop needs to read the contents of the framebuffer first before
writing.  And READS are slow on most PCI cards.

What I cannot understand is your aversion against softcursor.  For fbcon,
it works 100% of the time, guaranteed, for any kind of driver, fictional or
otherwise.

===========================================================================
Anyway, I really don't have a strong argument against adding FB_ACCEL_HWCUR
flag to fbdev.  What I'm against is the overloading of info->fbops->fb_cursor
for userspace. I'll try to clarify:

Almost all graphics hardware have support for a cursor, but they are designed
mainly for a mouse cursor, not a text cursor. So in fbdev/fbcon context,
what we have is a mouse cursor emulating a text cursor. The differences are:

1. Movement granularity of a text cursor is per character, mouse cursor is
per pixel. Also mouse cursor must have a low latency (try shaking your mouse)
and movement changes happen at a very fast rate.

2. A mouse cursor usually have a static image.  It does change from time to
time depending on the app. Basically, you load the image once and you can 
choose to forget about it. A text cursor image, on the other hand, changes
depending on the underlying character.

3. A mouse cursor usually has a static color.  A text cursor's color will
change a lot, especially if your editor has syntax highlighting enabled.

4. A mouse cursor is usually steady, a text cursor usually blinks.

5. The size of the cursor is unchanging for both mouse and text.

So we have these 5 characteristics of the cursor:

		text		mouse
-----------------------------------------
position	changing	changing (at a rapid rate)
size		static		static
image		changing	static
color		changing	static
show/hide	changing	static
 
Now, our info->fbops->fb_cursor() accepts a parameter struct fb_cursor which is
more than 100 bytes in size.  It has everything there in order to have a fully
functional cursor.  But, that's a lot of bytes to move.  This is probably okay
for the text cursor because the text cursor characteristics are usually in a
state of flux. For the mouse cursor, on the other hand, only the position is
usually changing.

So that's why I don't want info->fbops->fb_cursor to be used in user space.  It
is inefficient.  Why move 100 bytes of data to move the cursor to x,y? And then
you have to take into consideration that the rate of change is very rapid.

1. So what I want is to have another API for userspace use.  This API needs to
be broken down into something like below:

fb_cursor_move()
fb_cursor_size()
fb_cursor_load_image()
fb_cursor_load_color()
fb_cursor_show()

A typical app will call fb_cursor_move() magnitudes of times more compared
to the rest.  And if fb_cursor_move() accepts only 2 integers, x and y,
we're just moving 8 bytes, in contrast to 100 bytes.

If you think it's too much splitting, we can just split it into two, one for
the characteristics that changes a lot and another for characteristics that
are predominantly static.

Now this need not coexist side by side forever with fbcon's cursor. Once we
have appropriate testing of this new API, we can start porting drivers that
have a working implementation of the old API (there are 5 right now) to the
new one, Once all drivers are ported, we can remove the old API.  With this,
transition from the old API to the new need not be noticed by the general user.

OR 2. We can start overhauling info->fbops->fb_cursor right now, but at the
risk that any bugs will be felt painfully by the user.

OR 3. Let's forget about userspace cursor support.

Tony



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
