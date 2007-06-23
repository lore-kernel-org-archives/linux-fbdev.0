From: Bernhard Fischer <rep.dot.nop@gmail.com>
Subject: Re: [PATCH 3/4] fbdev: uvesafb driver
Date: Sat, 23 Jun 2007 13:51:22 +0200
Message-ID: <20070623115122.GI4096@aon.at>
References: <20070623105243.GD12623@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I249a-00035D-UP for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Jun 2007 04:51:47 -0700
Received: from warsl404pip2.highway.telekom.at ([195.3.96.113]
	helo=email.aon.at) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1I249Y-0001wi-0R for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Jun 2007 04:51:45 -0700
Content-Disposition: inline
In-Reply-To: <20070623105243.GD12623@spock.one.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2007 at 12:52:43PM +0200, Michal Januszewski wrote:

>+static void uvesafb_cn_callback(void *data)
>+{
>+	struct cn_msg *msg = (struct cn_msg *)data;
>+	struct uvesafb_task *utask = (struct uvesafb_task *)msg->data;
>+	struct uvesafb_ktask *task;
>+
>+	if (msg->seq >= UVESAFB_TASKS_MAX)
>+		return;
>+
>+	task = uvfb_tasks[msg->seq];
>+
>+	if (!task || msg->ack != task->ack)
>+		return;

You need utask only here, so could spare setting it before the
checking above.
>+
>+	memcpy(&task->t, utask, sizeof(struct uvesafb_task));
>+
>+	if (task->t.buf_len && task->buf)
>+		memcpy(task->buf, ((u8*)utask) + sizeof(struct uvesafb_task),
>+						task->t.buf_len);
>+
>+	complete(task->done);
>+	return;
>+}

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
