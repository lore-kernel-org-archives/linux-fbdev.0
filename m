Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D840C4167B
	for <linux-fbdev@archiver.kernel.org>; Mon,  6 Nov 2023 13:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjKFNMT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Nov 2023 08:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjKFNMQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 6 Nov 2023 08:12:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C847A9
        for <linux-fbdev@vger.kernel.org>; Mon,  6 Nov 2023 05:12:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7554C433C8;
        Mon,  6 Nov 2023 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276332;
        bh=jIyk3coOzPkBV7QTj0XHJadht8iHu2WOA0RmAbz1QIE=;
        h=Date:From:To:Subject:From;
        b=CdeT+bghz/6SUhDmih2XVDxCWSq6w1XXCXTsnPJhS8rc8D6JCPiMOUDVT5RJIiYlI
         Qc4IarbhXeben0qoE5DWE8KcE23gsCXFOzR+WNnXZKOnENVX9U85jEW4VMUiKa2iRV
         486iPmbWTcjqIbwtwxvhIEAeqpaOS9s8uuY4fp6k=
Date:   Mon, 6 Nov 2023 08:12:11 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-fbdev@vger.kernel.org
Subject: PSA: migrating linux-fbdev to new vger infrastructure
Message-ID: <20231106-nippy-woodlouse-of-luxury-a46ed7@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Good day!

I plan to migrate the linux-fbdev@vger.kernel.org list to the new
infrastructure this week. We're still doing it list-by-list to make sure that
we don't run into scaling issues with the new infra.

The migration will be performed live and should not require any downtime.
There will be no changes to how anyone interacts with the list after
migration is completed, so no action is required on anyone's part.

Please let me know if you have any concerns.

Best wishes,
-K
