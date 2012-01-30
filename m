From: vipul kumar samar <vipulkumar.samar@st.com>
Date: Mon, 30 Jan 2012 11:25:16 +0000
Subject: How to restore frame buffer contents on hibernation restore?
Message-Id: <4F267B4C.9000809@st.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

How can i restore frame buffer contents in case of hibernation??

FB memory is allocated through fixup calls and that area is not 
accessible to kernel. In case of hibernation while preparing kernel 
snapshot, FB is not accessible to kernel. That means kernel is not 
responsible to save content of FB.

How to restore frame buffer contents after restore??

Regards
Vipul Kumar Samar
