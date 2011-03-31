From: Peter Jones <pjones@redhat.com>
Date: Thu, 31 Mar 2011 14:33:48 +0000
Subject: [PATCH 0/2] Support incorrect UEFI Graphics Output Protocol fields.
Message-Id: <1301582030-10607-1-git-send-email-pjones@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patchset allows us to handle UEFI machines that have fields which
have partially incorrect data in the GOP mode line by overriding individual
fields with our DMI table.

