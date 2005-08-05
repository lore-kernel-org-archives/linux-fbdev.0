From: Jon Smirl <jonsmirl@gmail.com>
Subject: CRTC scanout buffer types
Date: Fri, 5 Aug 2005 16:19:25 -0400
Message-ID: <9e47339105080513195dee0804@mail.gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: DRI developer's list <dri-devel@lists.sourceforge.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

I've included the scanout types for the R200, what other ones are
supported by the various chips? For example I think the R300 can
scanout in floating point.

4bpp Indexed
8bpp Indexed
16bpp aRGB 1555
16bpp RGB 565
24bpp RGB 888
32bpp aRGB 8888
16bpp aRGB 4444
16bpp aIndex 88
32bpp aRGB 2:10:10:10 palette bypassed

Note, the r200 supports a lot more buffer formats, but these are the
only ones valid for scanout.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
--
