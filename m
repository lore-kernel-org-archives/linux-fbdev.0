From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 13 Jan 2014 15:22:32 +0000
Subject: [PATCH 0/4] delete useless variable
Message-Id: <1389629847-5330-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: brcm80211-dev-list@broadcom.com
Cc: kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

These patches delete declarations and initializations of variables that are
only assigned to constants but never used otherwise.

The complete semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
type T;
identifier i,i2;
position p;
@@

T i@p;
... 
i = i2

@@
type r.T;
identifier r.i;
constant c;
position p != r.p;
@@

-T i@p;
<... when != i
-i = c;
...>
// </smpl>

