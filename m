From: Siim Vahtre <siim@pld.ttu.ee>
Subject: 2.5.70-bk1 compilation error
Date: Tue, 27 May 2003 19:55:42 +0300 (EET DST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.53.0305271949510.10781@pitsa.pld.ttu.ee>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from wall.ttu.ee ([193.40.254.238])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Khjq-0006PT-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 27 May 2003 09:55:50 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


  CC [M]  drivers/video/i810/i810_main.o
In file included from drivers/video/i810/i810_main.c:56:
drivers/video/i810/i810.h:206: error: parse error before "agp_memory"
drivers/video/i810/i810.h:206: warning: no semicolon at end of struct or
union
drivers/video/i810/i810.h:207: warning: type defaults to `int' in
declaration of `i810_cursor_memory'
drivers/video/i810/i810.h:207: warning: data definition has no type or
storage class
drivers/video/i810/i810.h:208: error: parse error before '}' token
drivers/video/i810/i810.h:246: error: field `i810_gtt' has incomplete type
drivers/video/i810/i810_main.c: In function `i810fb_getcolreg':
drivers/video/i810/i810_main.c:1078: warning: comparison is always false
due to
limited range of data type
drivers/video/i810/i810_main.c: In function `i810fb_release_resource':
drivers/video/i810/i810_main.c:1887: error: dereferencing pointer to
incomplete
type
drivers/video/i810/i810_main.c:1889: error: dereferencing pointer to
incomplete
type
make[3]: *** [drivers/video/i810/i810_main.o] Error 1
make[2]: *** [drivers/video/i810] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

--
siim@void:~$ gcc --version
gcc (GCC) 3.3 (Debian)

CONFIG_DRM_I810=y
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
