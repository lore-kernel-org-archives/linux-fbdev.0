From: "Robert Bragg" <robert@sixbynine.org>
Subject: How can I hide flip latency?
Date: Wed, 25 Oct 2006 17:37:39 +0100
Message-ID: <e04d66f60610250937m1936b942o6a8716cd79551916@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GcllG-0005gE-Ba for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 09:37:50 -0700
Received: from nz-out-0102.google.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GcllC-00059Y-0P
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 09:37:50 -0700
Received: by nz-out-0102.google.com with SMTP id 9so188329nzo
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Oct 2006 09:37:40 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

I'm trying to find a way to support double/triple buffering using
fbdev such that when an application finishes rendering a frame it
doesn't need to immediately block and wait for a flip to really
happen, and can defer blocking until the last moment - which is the
point that you want to start rendering to a buffer that _might_ still
be visible.

Put another way; I want to hide vsync flip/pan latency by letting the
app do other things.

So for a double buffering app that is doing:

* process frame 1
* draw frame 1
* flip from 2->1
* process frame 2
* draw frame 2
* flip from 1->2
* process frame 1
* draw frame 1
* flip from 2->1
* etc

The application above should be able to e.g execute "process frame 2"
before it really needs to block for "flip from 2->1" to actually
complete on the hardware.

So in pseudo code I was imagining an API something like:


/* request pan/flip - getting back a token/handle
 * for this request
 */
ioctl(fb0, FBIO_FLIP_DISPLAY, &details, &token);

/* prepare the next frame */
process_frame();

/* make sure our previous flip request has finished */
ioctl(fb0, FBIO_FLIP_BLOCK, &token);

render_frame();


Can someone recommend a preferred way for me to achieve this using the
current interfaces or suggest another way to extend the interface to
allow this.

kind regards,
--
Robert

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
