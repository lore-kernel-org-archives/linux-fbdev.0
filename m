From: Antonino Daplas <adaplas@pol.net>
Subject: Feature Freeze?
Date: 05 Mar 2003 16:26:04 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046852721.1228.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qUCh-0004Tf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 00:24:43 -0800
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi,

I believe it's time to finalize what is needed/not needed for the
framebuffer framework:

1. Text mode support?

2. console resizing using fbset (besides stty)?

3. support for unloading of fbcon if modular?

4. driver specified placement of buffers - for putcs method?

5. flexible logo placement/overlayed logo?

6. generic console display rotation?

7. Anything else?

8. feature freeze deadline?

If you think any of the above is essential, useful, bloat, etc, please
say so.  If you think there are features in the present code that needs
to be removed, make it known.

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
