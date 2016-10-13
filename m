From: Scot Doyle <lkml14@scotdoyle.com>
Date: Thu, 13 Oct 2016 17:12:43 +0000
Subject: [PATCH] vt: clear selection before resizing
Message-Id: <alpine.DEB.2.20.1610131209180.5961@pc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CACT4Y+acDTwy4umEvf5ROBGiRJNrxHN4Cn5szCXE5Jw-d1B=Xw@mail.gmail.com> <CACT4Y+bGtZKy55Kwk_Jz7_P1SOihd8SksuSv7j4x5KDawsnamQ@mail.gmail.com> <alpine.DEB.2.20.1610111709120.25352@pc>
 <CACT4Y+a+kw-K8UmZMpmG7GrON5SaBVn4m_txGtDMPL4o2p7n0g@mail.gmail.com>
In-Reply-To: <CACT4Y+a+kw-K8UmZMpmG7GrON5SaBVn4m_txGtDMPL4o2p7n0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Dmitry Vyukov <dvyukov@google.com>, Peter Hurley <peter@hurleysoftware.com>, tomi.valkeinen@ti.com, jean-philippe.brucker@arm.com, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

When resizing a vt its selection may exceed the new size, resulting in
an invalid memory access [1]. Clear the selection before resizing.

[1] http://lkml.kernel.org/r/CACT4Y+acDTwy4umEvf5ROBGiRJNrxHN4Cn5szCXE5Jw-d1B=Xw@mail.gmail.com

Reported-and-tested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
---
 drivers/tty/vt/vt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 06fb39c..5d6a549 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -874,6 +874,9 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	if (!newscreen)
 		return -ENOMEM;
 
+	if (vc = sel_cons)
+		clear_selection();
+
 	old_rows = vc->vc_rows;
 	old_row_size = vc->vc_size_row;
 
-- 
2.7.4

