From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 21 Mar 2011 22:46:38 +0000
Subject: viafb fixes
Message-Id: <1300748487-9883-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This series contains two patches to fix handling of initial values 
selected via parameters. They are tested and confirmed to work on 
CLE266, VX800 and VX900.
They will show up in linux-next soon and are designated for 2.6.39, 
probably will go there at the end of the merge window or in an early 
release candidate.

Note:	These patches are minimal, further cleanup in this area is 
	planned for the next merge window.


Thanks,

Florian Tobias Schandinat

