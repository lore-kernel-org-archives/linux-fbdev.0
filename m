From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 29 Jul 2020 05:30:20 +0000
Subject: [PATCH] vt: Handle recursion in vc_do_resize().
Message-Id: <1596000620-4075-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>

syzbot is reporting OOB read bug in vc_do_resize() [1] caused by memcpy()
based on outdated old_{rows,row_size} values, for resize_screen() can
recurse into vc_do_resize() which changes vc->vc_{cols,rows} that outdates
old_{rows,row_size} values which were read before calling resize_screen().

Minimal fix might be to read vc->vc_{rows,size_row} after resize_screen().
A different fix might be to forbid recursive vc_do_resize() request.
I can't tell which fix is the better.

But since I guess that new_cols =3D vc->vc_cols && new_rows =3D vc->vc_rows
check could become true after returning from resize_screen(), and I assume
that not calling clear_selection() when resize_screen() will return error
is harmless, let's redo the check by moving resize_screen() earlier.

[1] https://syzkaller.appspot.com/bug?id=C70c88cfd16dcf6e1d3c7f0ab8648b3144=
b5b25e

Reported-by: syzbot <syzbot+c37a14770d51a085a520@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/vt/vt.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 42d8c67..952a067 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1217,7 +1217,24 @@ static int vc_do_resize(struct tty_struct *tty, stru=
ct vc_data *vc,
=20
 	if (new_cols =3D vc->vc_cols && new_rows =3D vc->vc_rows)
 		return 0;
+	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
+		return -EINVAL;
=20
+	/*
+	 * Since fbcon_resize() from resize_screen() can recurse into
+	 * this function via fb_set_var(), handle recursion now.
+	 */
+	err =3D resize_screen(vc, new_cols, new_rows, user);
+	if (err)
+		return err;
+	/* Reload values in case recursion changed vc->vc_{cols,rows}. */
+	new_cols =3D (cols ? cols : vc->vc_cols);
+	new_rows =3D (lines ? lines : vc->vc_rows);
+	new_row_size =3D new_cols << 1;
+	new_screen_size =3D new_row_size * new_rows;
+
+	if (new_cols =3D vc->vc_cols && new_rows =3D vc->vc_rows)
+		return 0;
 	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
 		return -EINVAL;
 	newscreen =3D kzalloc(new_screen_size, GFP_USER);
@@ -1238,13 +1255,6 @@ static int vc_do_resize(struct tty_struct *tty, stru=
ct vc_data *vc,
 	old_rows =3D vc->vc_rows;
 	old_row_size =3D vc->vc_size_row;
=20
-	err =3D resize_screen(vc, new_cols, new_rows, user);
-	if (err) {
-		kfree(newscreen);
-		vc_uniscr_free(new_uniscr);
-		return err;
-	}
-
 	vc->vc_rows =3D new_rows;
 	vc->vc_cols =3D new_cols;
 	vc->vc_size_row =3D new_row_size;
--=20
1.8.3.1
