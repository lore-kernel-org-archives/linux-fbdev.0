From: melodramus@online.de
Date: Wed, 31 Mar 2010 02:36:58 +0000
Subject: compiled-in console fonts on fb with 1600x1200 too small and slim
Message-Id: <20100331043658.46ab9e19.melodramus@online.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

hello

don't really know where to put this right. it is possibly best sent to the kbd-people but i'd like to see a further choice in menuconfig too.

this is just a pledge for the wishlist. 

i got ksm working with radeondrmfb. the resolution seems to be set correctly to 1600x1200i (or possibly just 1200x1024?). i'd like to keep that so because of crispness and fast switching between console and X. however, the few choices of console fonts in menuconfig are so small that the boot output is unreadable. even the greater fonts are unreadable, mainly because they are very slim and with serifs.

there is a great console-font package coming with a clean, default-font-like look and in lots of sizes/widths. it suppports more than hundred languages and is under the GPL 2 (and higher).

possibly you could take out some rare versions like ter-v24b and put them into linux?

here is the link: http://www.is-vn.bg/hamster/

many thanks for listening,
MeloDramus <melodramus@online.de>
