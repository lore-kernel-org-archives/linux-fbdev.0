From: Pavel Machek <pavel@ucw.cz>
Subject: Cursor problems still in test9
Date: Tue, 28 Oct 2003 10:49:08 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031028094907.GA1319@elf.ucw.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEQVC-0007Mi-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Oct 2003 01:51:02 -0800
Received: from gprs197-51.eurotel.cz ([160.218.197.51] helo=amd.ucw.cz)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AEQUH-0007TG-DY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 28 Oct 2003 01:50:11 -0800
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: kernel list <linux-kernel@vger.kernel.org>, jsimmons@infradead.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net

Hi!

[And they get worse in fbcon-test patches I tried].

Try this on 2.4 (with vesafb).

echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"

...then try it on 2.6, type foo in bash then delete it using
backspace; ghost cursors stay there. Run emacs and quit it (it sets
cursor to very visible). Boom, special cursor settings are gone.

And now, use gpm on text console to select some text. Hold down left
button, move mouse a bit. Sometimes cursor gets corrupted and stays
there.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
