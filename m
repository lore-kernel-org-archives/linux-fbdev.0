From: Frank Pan <frankpzh@gmail.com>
Date: Fri, 21 May 2010 09:52:39 +0000
Subject: Wide character support in fbcon
Message-Id: <AANLkTilzv9XWQbaFgQeqcGkbXsIqIz--3LJBI_a44OC5@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I'm going to add a feature to render characters have a larger width than usual.
This is used to display languages other than English, for example Chinese.

In parallel, load font from userspace/filesystem is also needed. The
quantity of such character is far more than ascii set.

Any suggestion is appreciated.

-- 
Frank Pan

Computer Science and Technology
Tsinghua University
